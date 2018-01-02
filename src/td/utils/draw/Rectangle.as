package td.utils.draw
{
	import starling.display.Quad;
	import starling.display.Sprite;

	public class Rectangle extends Primitive
	{
		private var baseQuad:Quad;
		private var _thickness:Number = 1;
		private var _color:uint = 0x000000;
		private var lines: Array;

		public function Rectangle(width: Number, height: Number, color: uint = 0x000000, colorLine: uint = 0x000000, lineThickness: Number = -1)
		{
			touchable = false;

			var quad: Quad = new Quad(width, height, color);
			addChild(quad);

			lines = [];
			if (lineThickness > 0) {
				lines.push(line(0, 0, width, 0, colorLine, lineThickness));
				lines.push(line(width, 0, width, height, colorLine, lineThickness));
				lines.push(line(width, height, 0, height, colorLine, lineThickness));
				lines.push(line(0, height, 0, 0, colorLine, lineThickness));
			}
		}

		public function changeBorderColor(color: uint): void {
			for (var i: uint = 0; i < this.lines.length; ++i) {
				this.lines[i].color = color;
			}
		}
	}
}