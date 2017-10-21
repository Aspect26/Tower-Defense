package td.ui
{
    public class MenuTextButton extends TextButton
	{

        private static const FONT_SIZE: int = 25;
        private static const WIDTH: int = 100;
        private static const BORDER: int = 4;

		public function MenuTextButton(text: String, onClick: Function, onClickArguments: Object = null) {
			super(text, FONT_SIZE, WIDTH, BORDER, onClick, onClickArguments);
        }
		
	}
}