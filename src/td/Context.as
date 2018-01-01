package td 
{
    import starling.display.Sprite;
	import starling.display.Stage;

    import td.dropable.CoinSprite;

    import td.map.MapLoader;
    import td.missiles.SimpleMissile;
    import td.music.MusicManager;
    import td.music.SoundManager;
    import td.screens.ScreenManager;
	import starling.textures.Texture;
	import starling.display.Image;

    import td.utils.pools.ObjectPool;

    /**
	 * Always good to have some global class containing statics of useful game stuff.
	 */
	public class Context 
	{
		/** Note that using 'statics' is not advised in AS3, we have it here for the sake of simplicity... */
		
		/** Top-level sprite */
		public static var game: Game;
		
		/** Stage3D */
		public static var stage: Stage;
		
		/** Gateway to textures **/
		public static var assets: Assets;
		
		/** Gateway to screens */
		public static var screenManager: ScreenManager;
		
		/** Gateway to I18N **/
		public static var texts: Texts;
		
		/** Gateway to dynamic constants */
		public static var values: Values;

        /** Gateway to map loading. */
        public static var mapLoader: MapLoader;

		/** Gateway to music manager */
		public static var musicManager: MusicManager;

        /** Gateway to sound manager */
        public static var soundManager: SoundManager;
		
		/** Shortcut for values.v */
		public static var v: * ;

        public static var missilesObjectPool: ObjectPool = new ObjectPool("Missile", "Missiles", function(): SimpleMissile {
            return new SimpleMissile()
        });

        public static var coinsObjectPool: ObjectPool = new ObjectPool("Coin", "Droppable", function(): CoinSprite {
			return new CoinSprite()
		});
		// ASSETS - SHORTCUTS

		public static function getTexture(name: String) : Texture {
			return assets.getTextureFromAtlas(name);
		}

		// SCREENMANAGER - SHORTCUTS
		
		public static function showScreen(screen: Sprite) : void {
			screenManager.showScreen(screen);
		}
		
		// TEXTS - SHORTCUTS
		
		public static function text(id: String) : String {
			return texts.text(id);
		}
		
		// UTILITIES
				
		public static function newImage(texName: String): Image {
			var tex: Texture = getTexture(texName);
			return new Image(tex);
		}

	}

}