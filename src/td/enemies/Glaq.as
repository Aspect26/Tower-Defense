package td.enemies {
    import flash.geom.Point;

    import td.Context;
    import td.constants.Images;

    public class Glaq extends Enemy {

        public function Glaq(path: Vector.<Point>, pathOffset: Point, timeOffset: Number) {
            super(Context.newImage(Images.ENEMY_GLAQ), path, pathOffset, timeOffset, 1.0);
        }

    }
}
