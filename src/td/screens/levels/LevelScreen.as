package td.screens.levels {

import com.greensock.TweenLite;
import com.greensock.easing.Power0;

import flash.events.Event;

import starling.core.Starling;
    import starling.text.TextField;
    import starling.display.Sprite;
    import starling.text.TextFieldAutoSize;

    import td.Context;
    import td.buildings.CannonTower;
    import td.buildings.RockTower;
    import td.buildings.WatchTower;
    import td.constants.Colors;
    import td.ui.NewTowerButton;

    public class LevelScreen extends Sprite
    {
        private var backgroundPath: String;
        private var introText: String;

        private var introTextField: TextField;
        private var background: Sprite;
        private var watchTowerButton: NewTowerButton;
        private var rockTowerButton: NewTowerButton;
        private var cannonTowerButton: NewTowerButton;

        public function LevelScreen(introText: String, backgroundPath: String)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            this.backgroundPath = backgroundPath;
            this.introText = introText;
        }

        private function onAddedToStage(event: * = null) : void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            this.initialize();
            this.playIntro();
            Starling.juggler.delayCall(this.startLevel, this.getIntroTextTime());
        }

        private function initialize() : void {
            this.initializeIntroText();
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

        private function initializeTowerButtons(): void {
            watchTowerButton = new NewTowerButton(new WatchTower(), 20, Context.stage.stageHeight - 90, newTowerClicked);
            rockTowerButton = new NewTowerButton(new RockTower(), 100, Context.stage.stageHeight - 90, newTowerClicked);
            cannonTowerButton = new NewTowerButton(new CannonTower(), 180, Context.stage.stageHeight - 90, newTowerClicked);
        }

        private function getIntroTextTime() : int {
            var scrollPathLength: int = Context.stage.stageHeight + introTextField.height;
            return scrollPathLength / 30;
        }

        private function playIntro() : void {
            this.addChild(introTextField);
        }

        private function startLevel() : void {
            this.removeChild(introTextField);
            this.addChild(background);
            this.addChild(watchTowerButton);
            this.addChild(rockTowerButton);
            this.addChild(cannonTowerButton);
        }

        private function newTowerClicked(event) : void {
            var a = 5;
        }

    }
}
