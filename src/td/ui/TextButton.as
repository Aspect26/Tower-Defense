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
        private var onClickArguments: Object;

        private var textField: TextField;
        private var borderRectangle: td.utils.draw.Rectangle;

		private var enabled: Boolean = true;

		public function TextButton(text: String, fontSize: int, width: int, border: int, onClick: Function, onClickArguments: Object = null)
		{
			setTouchable(true);
			
			this.onClickHandler = onClick;
            this.onClickArguments = onClickArguments;
			
			textField = new TextField(width, fontSize + 10, text, new TextFormat(Fonts.PRIMARY, fontSize, Colors.BLACK));
			textField.touchable = true;

            borderRectangle = rectangle(0, 0, textField.width + 10, textField.height + 10, Colors.WHITE, border, Colors.PRIMARY);
			
			textField.x = width / 2 - textField.width / 2;
			textField.y = height / 2 - textField.height / 2;
			
			addChild(textField);
		}

        public function setEnable(enabled: Boolean): void {
            this.enabled = enabled;
            if (enabled) {
                borderRectangle.changeBorderColor(Colors.PRIMARY);
            } else {
                borderRectangle.changeBorderColor(Colors.DISABLED);
            }
        }

		override public function onClick(event: TouchEvent) : void {
			if (this.onClickHandler != null && this.enabled) {
                if (onClickArguments) {
                    onClickHandler(onClickArguments);
                } else {
                    onClickHandler();
                }
			}
		}
		
	}
}