package td.ui
{
	import starling.display.Image;
	import starling.events.TouchEvent;

	import td.Context;

	import td.constants.Colors;
    import td.utils.draw.ImageUtils;
    import td.utils.draw.Primitive;
	
	public class ImageButton extends Primitive
	{
		private var onClickHandler: Function;
		private var image: Image;

		public function ImageButton(imagePath: String, x: int, y: int, width: int, height: int, onClick: Function, onlyImage: Boolean = false)
		{
			setTouchable(true);

            this.x = x;
            this.y = y;

			this.image = Context.newImage(imagePath);
			ImageUtils.resize(this.image, width, height);
            this.onClickHandler = onClick;

			if (!onlyImage) {
                rectangle(0, 0, width, height, Colors.WHITE, 2, Colors.PRIMARY);
            }
            this.addChild(this.image);
		}

		override public function onClick(event: TouchEvent) : void {
			if (this.onClickHandler != null) {
				onClickHandler(event);
			}
            event.stopImmediatePropagation();
		}
		
	}
}