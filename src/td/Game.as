package td
{  

	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.UncaughtErrorEvent;
	import flash.system.LoaderContext;

    import td.constants.Music;

    import td.map.MapLoader;
    import td.music.MusicManager;
    import td.music.SoundManager;
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
		public static const APP_VERSION:String = "0.8.1";
		
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
            new MusicManager();
            new SoundManager();
			
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
			
            // TODO: add player load
            this.player = new Player();

            var scale: Number = Starling.contentScaleFactor; // TODO: what if it is too high?? we do not have textures for that
			if (scale < 1.25) scale = 1.0;
			else if (scale < 1.75) scale = 1.5;
			else scale = Math.round(scale);

            Context.assets.setScaleFactor(scale);

            Context.assets.loadAssets(
                    loadProgress,
                    "assets/textures/" + scale + "x/sprites.png",
                    "assets/textures/" + scale + "x/sprites.xml",

                    Music.DARK_DESCENT,
                    Music.EPIC_BOSS_BATTLE,
                    Music.HEROES_THEME,
                    Music.HEROIC_DEMISE,
                    Music.BATTLE_THEME_A,
                    Music.IRELANDS_COAST,
                    Music.THE_DARK_AMULET,

                    Music.SOUND_BUTTON_CLICK,
                    Music.SOUND_COIN_DROP,
                    Music.SOUND_COIN_PICK,
                    Music.SOUND_DEATH_BLOOD_KNIGHT,
                    Music.SOUND_DEATH_GLAQ,
                    Music.SOUND_DEATH_SPAWN,
                    Music.SOUND_SHOT_1,
                    Music.SOUND_SHOT_2,
                    Music.SOUND_SHOT_3,
                    Music.SOUND_SHOT_4,
                    Music.SOUND_VICTORY
            );
        }
		
		
		private function loadProgress(ratio:Number):void
		{
			loadProgressBar.width = stage.stageWidth*ratio;
			loadProgressBar.y = stage.stageHeight >> 1;  
			
			trace("Loading assets, progress:", ratio);
			
			// -> When the ratio equals '1', we are finished.
			if (ratio >= 1.0){
                Context.soundManager.initialize();
				Starling.juggler.delayCall(startGame, 0.3);
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