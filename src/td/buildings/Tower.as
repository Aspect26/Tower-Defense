package td.buildings {

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import td.Context;
    import td.map.Map;
    import td.utils.Size;
    import td.utils.draw.ImageUtils;

    public class Tower {

        private var imagePath: String;

        private var damage: int;
        private var cooldawn: Number;
        private var size: Size;

        public function Tower(imagePath: String, damage: int, cooldawn: int, size: Size) {
            this.imagePath = imagePath;
            this.damage = damage;
            this.cooldawn = cooldawn;
            this.size = size;
        }

        public function getImagePath(): String {
            return this.imagePath;
        }

        public function getSize(): Size {
            return this.size;
        }

        public function getNewImage(): Image {
            var image: Image = Context.newImage(this.imagePath);
            ImageUtils.resize(image, this.size.width * Map.TILE_SIZE, this.size.height * Map.TILE_SIZE);

            return image;
        }

    }

}
