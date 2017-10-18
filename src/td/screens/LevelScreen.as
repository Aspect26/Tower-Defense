package td.screens {

    import com.greensock.easing.Bounce;
    import com.greensock.TweenLite;

    import flash.events.Event;

    import starling.core.Starling;
    import starling.text.TextField;
    import starling.display.Sprite;

    import td.Context;
    import td.constants.Colors;

    public class LevelScreen extends Sprite
    {
        private var backgroundPath: String;
        private var introText: String;

        private var introTextField: TextField;
        private var background: Sprite;

        public function LevelScreen(introText: String, backgroundPath: String)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            this.backgroundPath = backgroundPath;
            this.introText = introText;
        }

        private function onAddedToStage(e: * = null) : void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            this.initialize();
            this.playIntro();
            Starling.juggler.delayCall(this.startLevel, this.getIntroTextTime());
        }

        private function initialize() : void {
            this.initializeBackground();
        }

        private function initializeBackground() : void {
            background = new Sprite();
            background.x = Context.assets.stageWidth / 2;
            background.y = Context.assets.stageHeight / 2;
            background.width = 800;
            background.height = 500;
            background.addChild(Context.newImage(this.backgroundPath));
            background.alignPivot();

            introTextField = new TextField(200, 50, this.introText);
            introTextField.format.color = Colors.WHITE;
        }

        private function getIntroTextTime() : int {
            return this.introText.length / 7;
        }

        private function playIntro() : void {
            this.addChild(introTextField);
        }

        private function startLevel() : void {
            this.removeChild(introTextField);
            this.addChild(background);
        }

    }
}
