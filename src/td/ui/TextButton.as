package td.ui
{
	import starling.events.TouchEvent;
	import starling.text.TextFormat;
	import td.utils.draw.Primitive;
	
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.text.TextField;
	import starling.utils.Color;

	public class TextButton extends Primitive
	{
		private var onClickHandler: Function;
		
		private var tf:TextField;
		
		public function TextButton(text: String, fontSize: int, onClick: Function)
		{
			setTouchable(true);
			
			this.onClickHandler = onClick;
			
			tf = new TextField(text.length * 22, fontSize * 2, text, new TextFormat("Verdana", fontSize));
			tf.touchable = true;
			
			rectangle(0, 0, tf.textBounds.width + 10, tf.textBounds.height + 10, Color.WHITE, 2, Color.BLACK);
			
			tf.x = width / 2 - tf.width / 2;
			tf.y = height / 2 - tf.height / 2;
			
			addChild(tf);
		}
		
		override public function onClick(event: TouchEvent) : void {
			if (this.onClickHandler != null) {
				onClickHandler();
			}
		}
		
	}
}