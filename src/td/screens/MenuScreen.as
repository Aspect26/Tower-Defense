package td.screens 
{
	import com.greensock.easing.Power4;
    import com.greensock.TweenLite;

	import flash.events.Event;
    import flash.media.Sound;
    import flash.net.URLRequest;

    import td.Context;

    import td.constants.Images;
	import td.constants.TextIds;
	import td.levels.LevelManager;
	import td.ui.MenuTextButton;
	import td.Context;
    import td.utils.draw.ImageUtils;

	import starling.display.Image;
	import starling.display.Sprite;

    public class MenuScreen extends Sprite
	{
		private var background: Sprite;
		private var backgroundImg: Image;

		public function MenuScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e: * = null) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            this.setBackground();
            this.setButtons([
                new MenuTextButton(Context.text(TextIds.ButtonPlay), onPlay),
                new MenuTextButton(Context.text(TextIds.ButtonCredits), onCredits),
                new MenuTextButton(Context.text(TextIds.ButtonLevelSelect), onLevelSelect)
            ]);

			background.scale = 0;
            TweenLite.to(background, 1.5, { ease: Power4.easeInOut, scale: 1 });

            Context.musicManager.playMainMenuMusicIfNotPlaying();
		}

        private function setBackground(): void {
            this.background = new Sprite();
            this.background.x = Context.assets.stageWidth / 2;
            this.background.y = Context.assets.stageHeight / 2;
            this.background.width = Context.stage.stageWidth;
            this.background.height = Context.stage.stageHeight;
            this.addChild(background);

            this.backgroundImg = Context.newImage(Images.MENU_BACKGROUND);
            ImageUtils.resize(backgroundImg, Context.stage.stageWidth, Context.stage.stageHeight);
            this.background.addChild(backgroundImg);

            this.background.alignPivot();
        }

        private function setButtons(buttons: Array.<MenuTextButton>): void {
            var buttonHeight: int = buttons[0].height + 10;
            var currentY: int = Context.stage.height / 2 - ((buttonHeight*buttons.length) / 2);

            for (var i: int = 0; i < buttons.length; ++i) {
                var button: MenuTextButton = buttons[i];
                button.x = Context.assets.stageWidth / 2 - button.width / 2;
                button.y = currentY;
                this.background.addChild(button);
                currentY += buttonHeight;
            }
        }
		
		private static function onPlay() : void {
			Context.screenManager.showScreen(new LevelScreen(LevelManager.createLevel(1)));
		}

		private static function onCredits() : void {
			Context.screenManager.showScreen(new CreditsScreen());
		}

        private static function onLevelSelect(): void {
            Context.screenManager.showScreen(new LevelSelectScreen());
        }

	}

}