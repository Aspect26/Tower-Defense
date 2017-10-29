package td
{  

	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.UncaughtErrorEvent;
	import flash.system.LoaderContext;

    import td.map.MapLoader;
    import td.particles.ParticlesManager;
    import td.player.Player;
    import td.screens.MenuScreen;
	import td.screens.ScreenManager;
		
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import td.Context;
	import td.utils.ErrorDialog;
	
	import com.demonsters.debugger.MonsterDebugger;
	
    public class Game extends Sprite
    {
		/** Good to have around for your testers... */
		public static const APP_VERSION:String = "0.0.1";
		
		/** Here we save whether we're running within DEBUG version of Flash Player */
		public static var DEBUG:Boolean;
		
		/** Flash Loader */
		public static var starter:Object;
		
		/** For load() progress... */
		private var loadProgressBar:Quad;

		public var player: Player;
		
		public function Game()
        {    
			trace("Game created");
			
			CONFIG::debug {
				// MONSTER DEBUGGER ~ lib/MonsterDebugger-Starling.swc
				MonsterDebugger.initialize(this);
				MonsterDebugger.trace(this, "Hello World!");
			}	
			
			CONFIG::debug {		
				trace("IN CONFIG::DEBUG");
				try {
					DEBUG = (new Error().getStackTrace().search(/:[0-9]+]$/m) > -1);
				} catch (error: Error) {
					DEBUG = false;
				}
			}
			CONFIG::release {
				trace("IN CONFIG::RELEASE");
				DEBUG = false;
			}

			Context.game = this;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage); 					
		}
		
		private function onAddedToStage(event:Event):void
        {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initialize();
			load();
		}	
		
		/** INIT ALL SINGLETONS THAT DOES NOT REQUIRE ASSETS */
		private function initialize():void
		{
			Context.stage = stage;
			new Assets();
			new ScreenManager();
			new Texts();
			new Values();
			new ParticlesManager();
            new MapLoader();
			
			// SETS LANGUAGE
			Context.texts.setLanguage("eng");
			
			//UNCAUGHT ERROR EVENTS	
			starter.loaderInfo.uncaughtErrorEvents.addEventListener(
				UncaughtErrorEvent.UNCAUGHT_ERROR, function(event:UncaughtErrorEvent):void {	
					ErrorDialog.showError(event.error);
				}
			);
		}

		/** LOAD ALL INITIALLY REQUIRED ASSETS */
		private function load():void
		{
			loadProgressBar = new Quad(Context.assets.stageWidth, 3);
			addChild(loadProgressBar);
			loadProgressBar.width = 0;
			
			Context.assets.loadAssets(
				loadProgress,
				"assets/menu-background.png",
				"assets/menu-background.xml",

				"assets/levels/stage1/tiles.png",
				"assets/levels/stage1/tiles.xml",
                "assets/levels/stage1/enemies.png",
                "assets/levels/stage1/enemies.xml",
                "assets/levels/stage1/level1.png",
                "assets/levels/stage1/level1.xml",
                "assets/levels/stage1/level2.png",
                "assets/levels/stage1/level2.xml",
                "assets/levels/stage1/level3.png",
                "assets/levels/stage1/level3.xml",

                "assets/towers/towers.png",
                "assets/towers/towers.xml",

                "assets/bullets/bullets.png",
                "assets/bullets/bullets.xml"
			);

            // TODO: add player load
            this.player = new Player();
		}
		
		
		private function loadProgress(ratio:Number):void
		{
			loadProgressBar.width = stage.stageWidth*ratio;
			loadProgressBar.y = stage.stageHeight >> 1;  
			
			trace("Loading assets, progress:", ratio);
			
			// -> When the ratio equals '1', we are finished.
			if (ratio >= 1.0){
				Starling.juggler.delayCall( startGame, 0.3 );
				TweenLite.to(loadProgressBar, 1, { ease: Expo.easeInOut, alpha: 0 });				
			}
		}
		
		/** ASSETS LOADED -> SHOW FIRST SCREEN */
		private function startGame():void
		{
			removeChild(loadProgressBar);
			Context.showScreen(new MenuScreen());
		}
      
	}
	
}