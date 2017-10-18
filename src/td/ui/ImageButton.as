package td.ui
{
	import starling.display.Image;
	import starling.events.TouchEvent;

	import td.Context;

	import td.constants.Colors;
	import td.utils.draw.Primitive;
	
	public class ImageButton extends Primitive
	{
		private var onClickHandler: Function;
		private var image: Image;

		public function ImageButton(imagePath: String, x: int, y: int, width: int, height: int, onClick: Function)
		{
			setTouchable(true);

            this.x = x;
            this.y = y;

			this.image = Context.newImage(imagePath);
			this.scaleImageCorrectly(width, height);
            this.onClickHandler = onClick;

            rectangle(0, 0, width, height, Colors.WHITE, 2, Colors.PRIMARY);
            this.addChild(this.image);
		}

		private function scaleImageCorrectly(width: uint, height: uint) : void {
			var scaleRatio: Number = width / this.image.width;
			this.image.scaleX = scaleRatio;

            scaleRatio = height / this.image.height;
            this.image.scaleY = scaleRatio;
		}
		
		override public function onClick(event: TouchEvent) : void {
			if (this.onClickHandler != null) {
				onClickHandler(event);
			}
		}
		
	}
}