package td.ui
{
    import td.Context;

    public class MenuTextButton extends TextButton
	{
        private static const FONT_SIZE: int = 5;
        private static const WIDTH: Number = 0.6;

		public function MenuTextButton(text: String, onClick: Function, onClickArguments: Object = null) {
			super(text, FONT_SIZE, Context.stage.stageWidth * WIDTH, onClick, onClickArguments);
        }
		
	}
}