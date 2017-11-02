package td.screens 
{
	import com.greensock.easing.Power4;

	import flash.events.Event;

	import td.constants.Images;

	import td.constants.TextIds;
	import td.levels.LevelManager;

	import td.particles.ParticlesExample;
	import td.ui.MenuTextButton;
	import td.ui.TextButton;
	import td.Context;

	import starling.display.Image;
	import starling.display.Sprite;

	import com.greensock.TweenLite;

	public class MenuScreen extends Sprite
	{
		private var background: Sprite;
		private var backgroundImg: Image;
		private var playButton: TextButton;
		private var creditsButton: TextButton;
		private var levelSelectButton: TextButton;
		private var particles: ParticlesExample;
	
		public function MenuScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e: * = null) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            background = new Sprite();
			background.x = Context.assets.stageWidth / 2;
			background.y = Context.assets.stageHeight / 2;
			background.width = 800;
			background.height = 500;
			addChild(background);		
			
			backgroundImg = Context.newImage(Images.MENU_BACKGROUND);
			background.addChild(backgroundImg);
			
			background.alignPivot();
						
			playButton = new MenuTextButton(Context.text(TextIds.ButtonPlay), onPlay);
			playButton.x = Context.assets.stageWidth / 2 - playButton.width / 2;
			playButton.y = 200;
            background.addChild(playButton);

			creditsButton = new MenuTextButton(Context.text(TextIds.ButtonCredits), onCredits);
			creditsButton.x =  Context.assets.stageWidth / 2 - creditsButton.width / 2;
			creditsButton.y = 250;
            background.addChild(creditsButton);

            levelSelectButton = new MenuTextButton(Context.text(TextIds.ButtonLevelSelect), onLevelSelect);
            levelSelectButton.x = Context.assets.stageWidth / 2 - playButton.width / 2;
            levelSelectButton.y = 300;
            background.addChild(levelSelectButton);
			
			// USE MONSTER DEBUGGER TO FIND CORRECT X,Y,SCALE
			// TO FIT PARTICLES ONTO THE PLANE IN THE UPPER-RIGHT PART
			// OF BACKGROUND IMAGE
			particles = new ParticlesExample();
			particles.x = 487;
			particles.y = 40;
			particles.scale = 0.4;
			
			// TRY TO ATTACH PARTICLES ONTO DIFFERENT CONTAINER
			//addChild(particles);
			background.addChild(particles);
			
			particles.start();

			background.scale = 0;
            TweenLite.to(background, 1.5, { ease: Power4.easeInOut, scale: 1 });
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