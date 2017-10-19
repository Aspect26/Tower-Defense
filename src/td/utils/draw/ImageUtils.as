package td.utils.draw {
import starling.display.Image;

public class ImageUtils {

        public function ImageUtils() {

        }

        public static function resize(image: Image, width: Number, height: Number): void {
            var ratio: Number = width / image.width;
            image.scaleX = ratio;

            ratio = height / image.height;
            image.scaleY = ratio;
        }
    }

}
