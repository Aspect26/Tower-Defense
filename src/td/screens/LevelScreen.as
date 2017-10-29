package td.screens {

    import com.greensock.TweenLite;
    import com.greensock.easing.Power0;

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
    import td.enemies.Enemy;
    import td.levels.Level;
    import td.map.Map;
    import td.missiles.MissileHitTargetEvent;
    import td.missiles.SimpleMissile;
    import td.states.BuyingTowerState;
    import td.states.IntroState;
    import td.states.NormalState;
    import td.states.State;
    import td.ui.NewTowerButton;

    public class LevelScreen extends Sprite
    {
        private var introText: String;

        private var introTextField: TextField;
        private var moneyTextField: TextField;

        private var watchTowerButton: NewTowerButton;
        private var rockTowerButton: NewTowerButton;
        private var cannonTowerButton: NewTowerButton;

        private var level: Level;
        private var state: State;

        public function LevelScreen(level: Level)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(TouchEvent.TOUCH, onTouch);
            this.level = level;
            this.level.setScreen(this);
            this.introText = level.getIntroText();
        }

        private function onAddedToStage(event: * = null) : void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            this.initialize();
            this.playIntro();
            Starling.juggler.delayCall(this.startLevel, this.getIntroTextTime());
        }

        private function initialize() : void {
            this.initializeIntroText();
            this.initializeMoneyText();
            this.initializeTowerButtons();
        }

        private function initializeIntroText(): void {
            var padding: int = 220;
            var fontSize: int = 20;

            introTextField = new TextField(Context.stage.stageWidth - 2 * padding, 0, this.introText);
            introTextField.format.color = Colors.WHITE;
            introTextField.format.size = fontSize;
            introTextField.autoSize = TextFieldAutoSize.VERTICAL;
            introTextField.x = padding;
            introTextField.y = Context.stage.stageHeight;
            introTextField.alpha = 0;

            TweenLite.to(introTextField, getIntroTextTime(), { ease: Power0.easeNone, y: -introTextField.height });
            TweenLite.to(introTextField, 5, { ease: Power0.easeNone, alpha: 1});
        }

        private function initializeMoneyText(): void {
            var fontSize: int = 20;

            moneyTextField = new TextField(10, 10, this.level.getMoney() + " €");
            moneyTextField.format.color = Colors.YELLOW;
            moneyTextField.format.size = fontSize;
            moneyTextField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;

        }

        private function initializeTowerButtons(): void {
            watchTowerButton = new NewTowerButton(WatchTower.getDescriptor(), 20, Context.stage.stageHeight - 90, newTowerClicked);
            rockTowerButton = new NewTowerButton(RockTower.getDescriptor(), 100, Context.stage.stageHeight - 90, newTowerClicked);
            cannonTowerButton = new NewTowerButton(CannonTower.getDescriptor(), 180, Context.stage.stageHeight - 90, newTowerClicked);
        }

        private function getIntroTextTime() : int {
            var scrollPathLength: int = Context.stage.stageHeight + introTextField.height;
            return scrollPathLength / 30;
        }

        private function playIntro(): void {
            this.state = new IntroState();
            this.addChild(introTextField);
        }

        private function skipIntro(): void {
            Starling.juggler.removeDelayedCalls(this.startLevel);
            this.startLevel();
        }

        private function startLevel() : void {
            this.state = new NormalState();
            this.removeChild(introTextField);
            this.drawMap();
            this.insertEnemies();
            this.addChild(watchTowerButton);
            this.addChild(rockTowerButton);
            this.addChild(cannonTowerButton);
            this.addChild(moneyTextField);
            this.addEventListener(MissileHitTargetEvent.MISSILE_HIT_TARGET, onMissileHitTarget);
        }

        private function drawMap(): void {
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
                            addChild(image);
                        }
                    }
                }
            }
        }

        private function insertEnemies(): void {
            var enemies: Vector.<Enemy> = this.level.getEnemies();
            for (var i: int = 0; i < enemies.length; ++i) {
                var enemy: Enemy = enemies[i];
                this.addChild(enemy);
            }
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
            var position: Point = new Point(touch.globalX - touch.globalX % Map.TILE_SIZE, touch.globalY - touch.globalY % Map.TILE_SIZE);
            newState.setPosition(position);

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
                // TODO: creating new object!
                var position: Point = new Point(touch.globalX - touch.globalX % Map.TILE_SIZE, touch.globalY - touch.globalY % Map.TILE_SIZE);
                buyingTowerState.setPosition(position);
            }
        }

        private function onClick(touch: Touch): void {
            if (this.state is IntroState) {
                this.skipIntro();
            } else if (this.state is BuyingTowerState) {
                var state: BuyingTowerState = this.state as BuyingTowerState;
                var tower: Tower = state.instantiateTower(this.level);
                var towerPosition: Point = new Point((int)(touch.globalX / Map.TILE_SIZE), (int)(touch.globalY / Map.TILE_SIZE));
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
        }

        public function onMissileHitTarget(event: MissileHitTargetEvent): void {
            var missile: SimpleMissile = event.data as SimpleMissile;
            this.removeChild(missile);
        }

        public function setMoney(money: int): void {
            this.moneyTextField.text = money + " €";
        }

        public function addMissile(missile: SimpleMissile): void {
            this.addChild(missile);
        }

    }
}
