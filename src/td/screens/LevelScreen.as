package td.screens {

    import com.greensock.TweenLite;
    import com.greensock.easing.Elastic;
    import com.greensock.easing.Power0;
    import com.greensock.easing.Power1;

    import flash.events.Event;
    import flash.geom.Point;
    import flash.system.Capabilities;

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
    import td.dropable.MoneySprite;
    import td.enemies.Enemy;
    import td.events.EnemyDiedEvent;
    import td.events.LevelFinishedEvent;
    import td.events.MoneyPickedEvent;
    import td.levels.Level;
    import td.levels.LevelManager;
    import td.map.Map;
    import td.events.MissileHitTargetEvent;
    import td.missiles.SimpleMissile;
    import td.states.BuyingTowerState;
    import td.states.IntroState;
    import td.states.NormalState;
    import td.states.State;
    import td.ui.NewTowerButton;
    import td.utils.MathUtils;
    import td.utils.Utils;
    import td.utils.draw.ImageUtils;
    import td.utils.draw.Primitive;

    public class LevelScreen extends Sprite
    {
        private var content: Sprite;

        private var introTextField: TextField;
        private var moneyTextField: TextField;

        private var level: Level;
        private var state: State;

        public function LevelScreen(level: Level)
        {
            this.level = level;
            this.level.setScreen(this);  // TODO: refactor -> level should not know about screen (use event maybe)

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

            this.content = new Sprite();
            this.addChild(content);

            this.drawMap(this.content);
            this.drawMoneyText(this.content);
            this.drawTowerButtons(this.content);
            this.drawEnemies(this.content);


            this.addEventListener(MissileHitTargetEvent.TYPE, onMissileHitTarget);
            this.addEventListener(EnemyDiedEvent.TYPE, onEnemyDied);
            this.addEventListener(MoneyPickedEvent.TYPE, onMoneyPicked);
            this.addEventListener(LevelFinishedEvent.TYPE, onLevelFinished);

            ImageUtils.resizeSprite(this.content, Context.stage.stageWidth, Context.stage.stageHeight);
        }

        private function drawIntroTextField(target: Sprite): void {
            var padding: int = 220;
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

            moneyTextField = new TextField(10, 10, this.level.getMoney() + " €");
            moneyTextField.format.color = Colors.YELLOW;
            moneyTextField.format.size = fontSize;
            moneyTextField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;

            target.addChild(moneyTextField);
        }

        private function drawTowerButtons(target: Sprite): void {
            target.addChild(new NewTowerButton(WatchTower.getDescriptor(), 20, this.content.height - 90, newTowerClicked));
            target.addChild(new NewTowerButton(RockTower.getDescriptor(), 100, this.content.height - 90, newTowerClicked));
            target.addChild(new NewTowerButton(CannonTower.getDescriptor(), 180, this.content.height - 90, newTowerClicked));
        }

        private function drawMap(target: Sprite): void {
            var tiledMap: TiledMap = this.level.getMap().getMapData();
            for (var layerIndex: int = 0; layerIndex < tiledMap.layers.getAllLayers().length; ++layerIndex) {
                var layer: TiledTileLayer = tiledMap.layers.layers[layerIndex] as TiledTileLayer;
                if (layer == null) {
                    // TODO: handle omg
                    continue;
                }
                for (var x: int = 0; x < layer.width; ++x) {
                    for (var y: int = 0; y < layer.height; ++y) {
                        var tileData: TiledTile = layer.data[x][y];
                        if (tileData == null) {
                            // TODO: handle omg
                        } else {
                            var image: Image = Context.newImage(tileData.image.source);
                            image.x = x * tiledMap.tileWidth;
                            image.y = y * tiledMap.tileHeight;
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
            return scrollPathLength / 30;
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

            this.content.addChild(this.level.getOccupationOverlay());
            this.content.addChild(newState.getTowerOverlay());

            var touch: Touch = event.getTouch(Context.stage);

            var yPos: int = this.getContentLocalY(touch.globalY);
            var xPos: int = this.getContentLocalX(touch.globalX);

            var position: Point = new Point(xPos - xPos % Map.TILE_SIZE, yPos - yPos% Map.TILE_SIZE);
            newState.setPosition(position);

            this.content.addChild(newState.getTowerImage());
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

                var yPos: int = this.getContentLocalY(touch.globalY);
                var xPos: int = this.getContentLocalX(touch.globalX);

                var position: Point = new Point(xPos - xPos % Map.TILE_SIZE, yPos - yPos % Map.TILE_SIZE);
                buyingTowerState.setPosition(position);
            }
        }

        private function onClick(touch: Touch): void {
            if (this.state is IntroState) {
                this.skipIntro();
            } else if (this.state is BuyingTowerState) {
                var state: BuyingTowerState = this.state as BuyingTowerState;
                var tower: Tower = state.instantiateTower(this.level);

                var yPos: int = touch.globalY / this.content.scaleY;
                var xPos: int = touch.globalX / this.content.scaleX;

                var towerPosition: Point = new Point((int)(xPos / Map.TILE_SIZE), (int)(yPos / Map.TILE_SIZE));
                if (!level.addTower(tower, towerPosition)) {
                    return;
                }

                this.content.removeChild(level.getOccupationOverlay());
                this.content.removeChild(state.getTowerOverlay());
                this.content.removeChild(state.getTowerImage());
                this.state = new NormalState();

                tower.setPosition(new Point(towerPosition.x * Map.TILE_SIZE, towerPosition.y * Map.TILE_SIZE));
                this.content.addChild(tower);
            }
        }

        private function onMissileHitTarget(event: MissileHitTargetEvent): void {
            var missile: SimpleMissile = event.data as SimpleMissile;
            missile.hitTarget();
            this.content.removeChild(missile);
        }

        private function onEnemyDied(event: EnemyDiedEvent): void {
            var enemy: Enemy = event.data as Enemy;
            this.level.killEnemy(enemy);
            this.dropMoney(enemy.getPosition());

            TweenLite.to(enemy, Effects.TIME_ENEMY_DISAPPEAR_ON_DEATH, { ease: Power0.easeNone, alpha: 0.0 });
            Starling.juggler.delayCall(this.content.removeChild, Effects.TIME_ENEMY_DISAPPEAR_ON_DEATH, enemy);
        }

        private function onMoneyPicked(event: MoneyPickedEvent): void {
            var amount: int = event.data as int;
            var coinSprite: MoneySprite = event.moneySprite;
            this.level.addMoney(amount);
            TweenLite.to(coinSprite, Effects.TIME_COIN_DISAPPEAR_ON_PICK, { ease: Power0.easeNone, scale: Effects.SCALE_COIN_ON_PICK });
            TweenLite.to(coinSprite, Effects.TIME_COIN_DISAPPEAR_ON_PICK, { ease: Power0.easeNone, alpha: 0.0 });
            Starling.juggler.delayCall(this.content.removeChild, Effects.TIME_COIN_DISAPPEAR_ON_PICK, coinSprite);
        }

        private function onLevelFinished(event: LevelFinishedEvent): void {
            // TODO: play some victory sound
            Starling.juggler.delayCall(this.finishLevel, 1.0, event.data);
        }

        private function finishLevel(levelNumber: int): void {
            var blackOverlay: Primitive = Primitive.createRectangle(0, 0, Context.stage.stageWidth, Context.stage.stageHeight, Colors.BLACK, -1, 0, 0.0);
            this.content.addChild(blackOverlay);
            TweenLite.to(blackOverlay, Effects.TIME_LEVEL_BLACKOUT, { ease: Power0.easeNone, alpha: 1.0 });
            Starling.juggler.delayCall(startNextLevel, Effects.TIME_LEVEL_BLACKOUT);
            Context.game.player.finishedLevel(levelNumber);
        }

        private function startNextLevel(): void {
            Context.screenManager.showScreen(new LevelScreen(LevelManager.createLevel(this.level.getLevelNumber() + 1)))
        }

        public function setMoney(money: int): void {
            this.moneyTextField.text = money + " €";
        }

        public function addMissile(missile: SimpleMissile): void {
            this.content.addChild(missile);
        }

        private function dropMoney(position: Point): void {
            if (MathUtils.randomInt(1, 100) < Game.ADDITIONAL_MONEY_DROP_CHANCE) {
                var moneySprite: Sprite = new MoneySprite(position.x, position.y);
                const finalY: int = moneySprite.y - 40;
                const finalX: int = moneySprite.x + 20;
                this.content.addChild(moneySprite);
                TweenLite.to(moneySprite, 1.5, { ease: Elastic.easeOut.config(1, 0.3), y: finalY });
                TweenLite.to(moneySprite, 1.5, { ease: Power1.easeOut, x: finalX});
            }
        }

        private function getContentLocalY(yPos: int): int {
            return yPos / this.content.scaleY;
        }

        private function getContentLocalX(xPos: int): int {
            return xPos / this.content.scaleX;
        }

    }
}
