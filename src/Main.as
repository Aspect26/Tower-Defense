package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import starling.core.Starling;
	import flash.geom.Rectangle;
	import td.Game;
	
	import com.furusystems.dconsole2.DConsole;

	/**
	 * Entry point of the application.
	 */
	[SWF(width="800", height="500", frameRate="60", backgroundColor="#0")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main() 
		{
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		protected function loaderInfo_progressHandler(event:ProgressEvent):void
		{
			//this example draws a basic progress bar
			this.graphics.clear();
			this.graphics.beginFill(0x686868);
			var gY:int = (this.stage.stageHeight - 12) / 2;
			var gWidth:int = this.stage.stageWidth * event.bytesLoaded / event.bytesTotal;
			this.graphics.drawRect(0, gY, gWidth, 12);
			this.graphics.endFill();
		}
		
		protected function loaderInfo_completeHandler(event:Event):void
		{
			// unregister event handlers...
			this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
			this.loaderInfo.removeEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			
			//get rid of the progress bar
			this.graphics.clear();			
			
			// default line style
			this.graphics.lineStyle(1, 0xFFFFFF);
			
			// Scaling of the graphics...
			stage.scaleMode = "noScale"; // StageScaleMode.NO_SCALE ... See: http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/StageScaleMode.html
			
			// How "width,y" coords of sprites are treated...
			stage.align = "TL"; // StageAlign.TOP_LEFT ... See: http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/StageAlign.html

			// (true - useful on mobile devices)
			Starling.multitouchEnabled = false;

            var screenWidth:int  = this.stage.fullScreenWidth;
            var screenHeight:int = this.stage.fullScreenHeight;
            var viewPort: Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);

			Game.starter = this;
			_starling = new Starling(Game, this.stage, viewPort);
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = false;
			_starling.start();

			CONFIG::debug {
				// DOOMSDAY CONSOLE ~ lib/DConsole2.3.swc
				stage.addChild(DConsole.view); // Ctrl+Shift+Enter to show/hide				
			}
		}
				
	}
	
}