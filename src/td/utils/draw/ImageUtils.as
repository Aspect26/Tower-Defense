package td.utils.draw {
import starling.display.Image;
    import starling.display.Sprite;

    public class ImageUtils {

        public function ImageUtils() {

        }

        public static function resize(image: Image, width: Number, height: Number): void {
            var ratio: Number = width / image.width;
            image.scaleX = ratio;

            ratio = height / image.height;
            image.scaleY = ratio;
        }

        public static function resizeSprite(sprite: Sprite, width: Number, height: Number): void {
            var ratio: Number = width / sprite.width;
            sprite.scaleX = ratio;

            ratio = height / sprite.height;
            sprite.scaleY = ratio;
        }
    }

}
