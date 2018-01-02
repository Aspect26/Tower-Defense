package td.screens {

    import com.greensock.TweenLite;
    import com.greensock.easing.Elastic;
    import com.greensock.easing.Power0;
    import com.greensock.easing.Power1;

    import flash.events.Event;
    import flash.geom.Point;

    import io.arkeus.tiled.TiledMap;
    import io.arkeus.tiled.TiledTile;
    import io.arkeus.tiled.TiledTileLayer;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.display.Sprite;
    import starling.text.TextFieldAutoSize;

    import td.Context;
    import td.buildings.CannonTower;
    import td.buildings.RockTower;
    import td.buildings.Tower;
    import td.buildings.TowerDescriptor;
    import td.buildings.WatchTower;
    import td.constants.Colors;
    import td.constants.Effects;
    import td.constants.Game;
    import td.dropable.CoinSprite;
    import td.enemies.Enemy;
    import td.events.EnemyDiedEvent;
    import td.events.EnemyReachedEndEvent;
    import td.events.LevelFinishedEvent;
    import td.events.MoneyPickedEvent;
    import td.events.TowerRemoveRequest;
    import td.events.TowerSelectedEvent;
    import td.levels.Level;
    import td.levels.LevelManager;
    import td.map.Map;
    import td.events.MissileHitTargetEvent;
    import td.missiles.SimpleMissile;
    import td.music.SoundManager;
    import td.states.BuyingTowerState;
    import td.states.IntroState;
    import td.states.NormalState;
    import td.states.State;
    import td.ui.NewTowerButton;
    import td.utils.MathUtils;
    import td.utils.TowerSelection;
    import td.utils.Utils;
    import td.utils.draw.Primitive;

    public class LevelScreen extends Sprite
    {
        private var introTextField: TextField;
        private var moneyTextField: TextField;

        private var level: Level;
        private var state: State;
        private var towerSelection: TowerSelection;

        public function LevelScreen(level: Level)
        {
            this.level = level;
            this.level.setScreen(this);  // TODO: refactor -> level should not know about screen (use event maybe)
            this.towerSelection = new TowerSelection();

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(TouchEvent.TOUCH, onTouch);
        }

        private function onAddedToStage(event: * = null) : void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            this.playIntro();
            Starling.juggler.delayCall(this.startLevel, this.getIntroTextTime());
            Context.musicManager.playLevelMusic();
        }

        private function playIntro(): void {
            this.state = new IntroState();

            this.drawIntroTextField(this);

            TweenLite.to(introTextField, getIntroTextTime(), { ease: Power0.easeNone, y: -introTextField.height });
            TweenLite.to(introTextField, 5, { ease: Power0.easeNone, alpha: 1});
        }

        private function startLevel() : void {
            this.state = new NormalState();
            this.removeChild(introTextField);

            this.drawMap(this);
            this.drawMoneyText(this);
            this.drawTowerButtons(this);
            this.drawEnemies(this);

            this.addEventListener(MissileHitTargetEvent.TYPE, onMissileHitTarget);
            this.addEventListener(EnemyDiedEvent.TYPE, onEnemyDied);
            this.addEventListener(EnemyReachedEndEvent.TYPE, onEnemyReachedEnd);
            this.addEventListener(MoneyPickedEvent.TYPE, onCoinPicked);
            this.addEventListener(LevelFinishedEvent.TYPE, onLevelFinished);
            this.addEventListener(TowerSelectedEvent.TYPE, onTowerSelected);
            this.addEventListener(TowerRemoveRequest.TYPE, onTowerRemoveRequest);
        }

        private function drawIntroTextField(target: Sprite): void {
            var padding: int = 40;
            var fontSize: int = Utils.getFontSize(10);

            introTextField = new TextField(Context.stage.stageWidth - 2 * padding, 0, this.level.getIntroText());
            introTextField.format.color = Colors.WHITE;
            introTextField.format.size = fontSize;
            introTextField.autoSize = TextFieldAutoSize.VERTICAL;
            introTextField.x = padding;
            introTextField.y = Context.stage.stageHeight;
            introTextField.alpha = 0;

            target.addChild(introTextField);
        }

        private function drawMoneyText(target: Sprite): void {
            var fontSize: int = 20;

            moneyTextField = new TextField(10, 10, "Coins " + this.level.getMoney());
            moneyTextField.format.color = Colors.YELLOW;
            moneyTextField.format.size = fontSize;
            moneyTextField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;

            target.addChild(moneyTextField);
        }

        private function drawTowerButtons(target: Sprite): void {
            target.addChild(new NewTowerButton(WatchTower.getDescriptor(), 10, target.height - 40, newTowerClicked));
            target.addChild(new NewTowerButton(RockTower.getDescriptor(), 45, target.height - 40, newTowerClicked));
            target.addChild(new NewTowerButton(CannonTower.getDescriptor(), 80, target.height - 40, newTowerClicked));
        }

        private function drawMap(target: Sprite): void {
            var tiledMap: TiledMap = this.level.getMap().getMapData();
            for (var layerIndex: int = 0; layerIndex < tiledMap.layers.getAllLayers().length; ++layerIndex) {
                var layer: TiledTileLayer = tiledMap.layers.layers[layerIndex] as TiledTileLayer;
                if (layer == null) {
                    // TODO: handle omg
                    continue;
                }
                for (var y: int = 0; y < layer.height; ++y) {
                    for (var x: int = 0; x < layer.width; ++x) {
                        var tileData: TiledTile = layer.data[x][y];
                        if (tileData == null) {
                            // TODO: handle omg
                        } else {
                            var image: Image = Context.newImage(tileData.image.source);
                            var yOffset: int = -(image.height - Map.TILE_SIZE);
                            // The yOffset is because of props which are larger than actual tiles. And the problem is,
                            // that starling pivots image to TOP LEFT CORNER, while Tiled pivots at BOTTOM LEFT TILE.
                            image.x = x * Map.TILE_SIZE;
                            image.y = y * Map.TILE_SIZE + yOffset;
                            target.addChild(image);
                        }
                    }
                }
            }
        }

        private function drawEnemies(target: Sprite): void {
            var enemies: Vector.<Enemy> = this.level.getEnemies();
            for (var i: int = 0; i < enemies.length; ++i) {
                var enemy: Enemy = enemies[i];
                target.addChild(enemy);
            }
        }

        private function getIntroTextTime() : int {
            var scrollPathLength: int = Context.stage.stageHeight + introTextField.height;
            return scrollPathLength / 10;
        }

        private function skipIntro(): void {
            Starling.juggler.removeDelayedCalls(this.startLevel);
            this.startLevel();
        }

        private function newTowerClicked(event): void {
            // TODO: refactor this method
            var towerDescriptor: TowerDescriptor = event.currentTarget.getTowerDescriptor();
            if (towerDescriptor.getCost() > this.level.getMoney()) {
                return;
            }

            var newState: BuyingTowerState = new BuyingTowerState(towerDescriptor);
            this.state = newState;

            this.addChild(this.level.getOccupationOverlay());
            this.addChild(newState.getTowerOverlay());

            var touch: Touch = event.getTouch(Context.stage);

            var yPos: int = this.getContentLocalY(touch.globalY);
            var xPos: int = this.getContentLocalX(touch.globalX);

            newState.setPosition(xPos - xPos % Map.TILE_SIZE, yPos - yPos% Map.TILE_SIZE);

            this.addChild(newState.getTowerImage());
        }

        private function onTouch(event: TouchEvent): void {
            var touch: Touch = event.getTouch(Context.stage);
            if (touch) {
                switch (touch.phase) {
                    case TouchPhase.HOVER:
                    case TouchPhase.MOVED:
                        this.onHover(touch);
                        break;
                    case TouchPhase.BEGAN:
                        this.onClick(touch);
                        break;
                }
            }
        }

        private function onHover(touch: Touch): void {
            if (state is BuyingTowerState) {
                var buyingTowerState: BuyingTowerState = state as BuyingTowerState;

                var tower: TowerDescriptor = buyingTowerState.getTowerDescriptor();
                var yPos: int = this.getContentLocalY(touch.globalY) - (tower.getSize().width * Map.TILE_SIZE) / 2;
                var xPos: int = this.getContentLocalX(touch.globalX) - (tower.getSize().height * Map.TILE_SIZE) / 2;

                var x: int = xPos - xPos % Map.TILE_SIZE;
                var y: int = yPos - yPos % Map.TILE_SIZE;
                buyingTowerState.setPosition(x, y);
            }
        }

        private function onClick(touch: Touch): void {
            if (this.state is IntroState) {
                this.skipIntro();
            } else if (this.state is BuyingTowerState) {
                var state: BuyingTowerState = this.state as BuyingTowerState;
                var tower: Tower = state.instantiateTower(this.level);

                var yPos: int = this.getContentLocalY(touch.globalY) - (tower.getSize().width * Map.TILE_SIZE) / 2;
                var xPos: int = this.getContentLocalX(touch.globalX) - (tower.getSize().height * Map.TILE_SIZE) / 2;

                var towerPosition: Point = new Point((int)(xPos / Map.TILE_SIZE), (int)(yPos / Map.TILE_SIZE));
                if (!level.addTower(tower, towerPosition)) {
                    return;
                }

                this.removeChild(level.getOccupationOverlay());
                this.removeChild(state.getTowerOverlay());
                this.removeChild(state.getTowerImage());
                this.state = new NormalState();

                tower.setPosition(new Point(towerPosition.x * Map.TILE_SIZE, towerPosition.y * Map.TILE_SIZE));
                this.addChild(tower);
            }

            this.unselectTower();
        }

        private function onMissileHitTarget(event: MissileHitTargetEvent): void {
            var missile: SimpleMissile = event.data as SimpleMissile;
            level.missileHitTarget(missile);
            this.removeChild(missile);
        }

        private function onEnemyDied(event: EnemyDiedEvent): void {
            var enemy: Enemy = event.data as Enemy;
            this.level.killEnemy(enemy);
            this.dropCoin(enemy.getX(), enemy.getY());

            TweenLite.to(enemy, Effects.TIME_ENEMY_DISAPPEAR_ON_DEATH, { ease: Power0.easeNone, alpha: 0.0 });
            Starling.juggler.delayCall(this.removeChild, Effects.TIME_ENEMY_DISAPPEAR_ON_DEATH, enemy);
        }

        private function onEnemyReachedEnd(event: EnemyReachedEndEvent): void {
            // TODO: remove this!!!!!
            return;

            this.removeEventListener(EnemyReachedEndEvent.TYPE, onEnemyReachedEnd);
            var blackOverlay: Primitive = Primitive.createRectangle(0, 0, Context.stage.stageWidth, Context.stage.stageHeight, Colors.BLACK, -1, 0, 0.0);
            this.addChild(blackOverlay);
            TweenLite.to(blackOverlay, Effects.TIME_LEVEL_BLACKOUT, { ease: Power0.easeNone, alpha: 1.0 });
            Starling.juggler.delayCall(returnToMenuScreen, Effects.TIME_LEVEL_FAILED_BLACKOUT);
        }

        private function onCoinPicked(event: MoneyPickedEvent): void {
            var amount: int = event.data as int;
            var coinSprite: CoinSprite = event.moneySprite;
            this.level.addMoney(amount);
            TweenLite.to(coinSprite, Effects.TIME_COIN_DISAPPEAR_ON_PICK, { ease: Power0.easeNone, scale: Effects.SCALE_COIN_ON_PICK });
            TweenLite.to(coinSprite, Effects.TIME_COIN_DISAPPEAR_ON_PICK, { ease: Power0.easeNone, alpha: 0.0 });
            Starling.juggler.delayCall(function(coinSprite: CoinSprite): void {
                removeChild(coinSprite);
                Context.coinsObjectPool.back(coinSprite);
            }, Effects.TIME_COIN_DISAPPEAR_ON_PICK, coinSprite);
        }

        private function onLevelFinished(event: LevelFinishedEvent): void {
            Context.soundManager.playSound(SoundManager.VICTORY);
            Starling.juggler.delayCall(this.finishLevel, 1.0, event.data);
        }

        private function onTowerSelected(event: TowerSelectedEvent): void {
            this.addChild(this.towerSelection);
            this.towerSelection.select(event.getTower());
        }

        private function onTowerRemoveRequest(event: TowerRemoveRequest): void {
            var removingTower: Tower = event.getTower();
            this.level.removeTower(removingTower);
            this.removeChild(removingTower);
            this.unselectTower();
        }

        private function unselectTower(): void {
            this.towerSelection.unselect();
            this.removeChild(this.towerSelection);
        }

        private function finishLevel(levelNumber: int): void {
            var blackOverlay: Primitive = Primitive.createRectangle(0, 0, Context.stage.stageWidth, Context.stage.stageHeight, Colors.BLACK, -1, 0, 0.0);
            this.addChild(blackOverlay);
            TweenLite.to(blackOverlay, Effects.TIME_LEVEL_BLACKOUT, { ease: Power0.easeNone, alpha: 1.0 });
            Starling.juggler.delayCall(startNextLevel, Effects.TIME_LEVEL_BLACKOUT);
            Context.game.player.finishedLevel(levelNumber);
        }

        private function startNextLevel(): void {
            Context.screenManager.showScreen(new LevelScreen(LevelManager.createLevel(this.level.getLevelNumber() + 1)))
        }

        private function returnToMenuScreen(): void {
            Context.screenManager.showScreen(new MenuScreen())
        }

        public function setMoney(money: int): void {
            this.moneyTextField.text = "Coins: " + money;
        }

        public function addMissile(missile: SimpleMissile): void {
            this.addChild(missile);
        }

        private function dropCoin(x: int, y: int): void {
            if (MathUtils.randomInt(1, 100) < Game.ADDITIONAL_MONEY_DROP_CHANCE) {
                var coinSprite: CoinSprite = Context.coinsObjectPool.get();
                coinSprite.reinitialize(x, y);
                const finalY: int = coinSprite.y - 10;
                const finalX: int = coinSprite.x + 5;
                this.addChild(coinSprite);
                TweenLite.to(coinSprite, 1.5, { ease: Elastic.easeOut.config(1, 0.3), y: finalY });
                TweenLite.to(coinSprite, 1.5, { ease: Power1.easeOut, x: finalX});
            }
        }

        private function getContentLocalY(yPos: int): int {
            return yPos / this.scaleY;
        }

        private function getContentLocalX(xPos: int): int {
            return xPos / this.scaleX;
        }

    }
}
