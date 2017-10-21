package td.screens {

    import starling.events.Event;
    import starling.text.TextField;
    import starling.display.Sprite;
    import starling.text.TextFieldAutoSize;

    import td.Context;

    import td.constants.Colors;
    import td.constants.TextIds;
    import td.levels.LevelManager;
    import td.ui.MenuTextButton;
    import td.ui.TextButton;

    public class LevelSelectScreen extends Sprite {
        private var backButton: TextButton;
        private var titleText: String;
        private var introTextField: TextField;

        public function LevelSelectScreen()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(e: * = null) : void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            this.initialize();
            this.show();
        }

        private function initialize(): void {
            this.initializeTitle();
            this.initializeBackButton();
        }

        private function initializeTitle(): void {
            introTextField = new TextField(200, 50, Context.text(TextIds.Level));
            introTextField.format.color = Colors.WHITE;
        }

        private function initializeBackButton(): void {
            backButton = new MenuTextButton(Context.text(TextIds.ButtonBack), onBack);
            backButton.x = 10;
            backButton.y = Context.stage.stageHeight - backButton.height - 10;
        }

        private function show(): void {
            this.addChild(introTextField);
            this.addChild(backButton);

            this.addLevelSelectButtons();
        }

        private function addLevelSelectButtons(): void {
            for (var stage: int = 1; stage < 4; ++stage) {
                var stageText: TextField = new TextField(10, 10, Context.text(TextIds.Stage) + " " + stage);
                stageText.x = 180;
                stageText.y = 100 + stage * 60;
                stageText.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
                stageText.format.color = Colors.WHITE;
                stageText.format.size = 20;
                this.addChild(stageText);

                for (var level: int = 1; level < 4; ++level) {
                    var button: MenuTextButton =  new MenuTextButton(Context.text(TextIds.Level) + " " +  level,
                            onLevelSelected, {'level': level * stage});
                    button.x = 150 + level * (button.width + 10);
                    button.y = 100 + stage * (button.height + 10);
                    button.setEnable(Context.game.player.getUnlockedLevels() >= stage * level);
                    this.addChild(button);
                }
            }
        }

        private static function onBack(): void {
            Context.screenManager.showScreen(new MenuScreen());
        }

        private static function onLevelSelected(arguments: Object): void {
            Context.screenManager.showScreen(new LevelScreen(LevelManager.createLevel(arguments.level)))
        }

    }
}
