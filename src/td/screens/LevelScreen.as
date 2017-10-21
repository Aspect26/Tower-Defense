package td.screens {

    import com.greensock.TweenLite;
    import com.greensock.easing.Power0;

    import flash.events.Event;

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
    import td.buildings.WatchTower;
    import td.constants.Colors;
    import td.levels.Level;
    import td.map.Map;
    import td.states.BuyingTowerState;
    import td.states.IntroState;
    import td.states.NormalState;
    import td.states.State;
    import td.ui.NewTowerButton;
    import td.utils.Position;
    import td.utils.draw.Primitive;

    public class LevelScreen extends Sprite
    {
        private var backgroundPath: String;
        private var introText: String;

        private var introTextField: TextField;
        private var moneyTextField: TextField;
        private var background: Sprite;
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
            this.backgroundPath = level.getBackgroundPath();
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
            this.initializeBackground();
            this.initializeTowerButtons();
        }

        private function initializeBackground() : void {
            background = new Sprite();
            background.x = Context.assets.stageWidth / 2;
            background.y = Context.assets.stageHeight / 2;
            background.width = 800;
            background.height = 500;
            background.addChild(Context.newImage(this.backgroundPath));
            background.alignPivot();
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
            watchTowerButton = new NewTowerButton(new WatchTower(), 20, Context.stage.stageHeight - 90, newTowerClicked);
            rockTowerButton = new NewTowerButton(new RockTower(), 100, Context.stage.stageHeight - 90, newTowerClicked);
            cannonTowerButton = new NewTowerButton(new CannonTower(), 180, Context.stage.stageHeight - 90, newTowerClicked);
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
            this.addChild(background);
            this.addChild(watchTowerButton);
            this.addChild(rockTowerButton);
            this.addChild(cannonTowerButton);
            this.addChild(moneyTextField);
        }

        private function newTowerClicked(event): void {
            // TODO: refactor this method
            this.state = new BuyingTowerState(event.currentTarget.getNewTower());
            this.addChild(this.level.getOccupationOverlay());

            var towerImage: Image = (state as BuyingTowerState).getTowerImage();
            var towerOverlay: Primitive = (state as BuyingTowerState).getTowerOverlay();

            var touch: Touch = event.getTouch(Context.stage);
            var position: Position = new Position(touch.globalX - touch.globalX % Map.TILE_SIZE, touch.globalY - touch.globalY % Map.TILE_SIZE);
            (state as BuyingTowerState).setPosition(position);

            this.addChild(towerImage);
            this.addChild(towerOverlay);
        }

        private function onTouch(event: TouchEvent): void {
            var touch: Touch = event.getTouch(Context.stage);
            if (touch) {
                trace(touch.phase);
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
                var position: Position = new Position(touch.globalX - touch.globalX % Map.TILE_SIZE, touch.globalY - touch.globalY % Map.TILE_SIZE);
                buyingTowerState.setPosition(position);
            }
        }

        private function onClick(touch: Touch): void {
            if (state is IntroState) {
                this.skipIntro();
            } else if (state is BuyingTowerState) {
                var tower: Tower = (state as BuyingTowerState).getTower();
                var towerPosition: Position = new Position(touch.globalX / Map.TILE_SIZE, touch.globalY / Map.TILE_SIZE);
                if (!level.addTower(tower, towerPosition)) {
                    return;
                }

                this.removeChild(level.getOccupationOverlay());
                this.removeChild((state as BuyingTowerState).getTowerOverlay());
                state = new NormalState();
            }
        }

        public function setMoney(money: int): void {
            this.moneyTextField.text = money + " €";
        }

    }
}