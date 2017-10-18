package td.ui
{
	import starling.events.TouchEvent;
	import starling.text.TextFormat;

	import td.constants.Colors;
	import td.constants.Fonts;
	import td.utils.draw.Primitive;
	
	import starling.text.TextField;

	public class TextButton extends Primitive
	{
		private var onClickHandler: Function;
		private var textField: TextField;
		
		public function TextButton(text: String, fontSize: int, width: int, onClick: Function)
		{
			setTouchable(true);
			
			this.onClickHandler = onClick;
			
			textField = new TextField(width, fontSize, text, new TextFormat(Fonts.PRIMARY, fontSize, Colors.BLACK));
			textField.touchable = true;
			
			rectangle(0, 0, textField.width + 10, textField.height + 10, Colors.WHITE, 2, Colors.PRIMARY);
			
			textField.x = width / 2 - textField.width / 2;
			textField.y = height / 2 - textField.height / 2;
			
			addChild(textField);
		}
		
		override public function onClick(event: TouchEvent) : void {
			if (this.onClickHandler != null) {
				onClickHandler();
			}
		}
		
	}
}