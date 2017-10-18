package td.screens 
{
	import starling.display.Sprite;
	import td.Context;
	
	/**
	 * ScreenManager entry point; manages screens.
	 * @author Jakub Gemrot
	 */
	public class ScreenManager 
	{
		
		private var currentScreen: Sprite;
		
		public function ScreenManager() 
		{
			Context.screenManager = this;
		}
		
		public function showScreen( screen:Sprite ):void {
			if( currentScreen ){
				Context.game.removeChild(currentScreen,true);
			}
			currentScreen = screen;
			Context.game.addChild(screen);
		}
		
	}

}