package td.enemies {
    import flash.geom.Point;

    import td.Context;
    import td.constants.Images;
    import td.music.SoundManager;

    public class Glaq extends Enemy {

        public function Glaq(path: Vector.<Point>, pathOffset: Point, timeOffset: Number, boost: Number = 1.0) {
            super(Context.newImage(Images.ENEMY_GLAQ), SoundManager.DEATH_GLAQ, 12, 3, path, pathOffset, timeOffset, 1.0, boost);
        }

    }
}
