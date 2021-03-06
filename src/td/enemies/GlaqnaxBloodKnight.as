package td.enemies {
    import flash.geom.Point;

    import td.Context;
    import td.constants.Images;
    import td.music.SoundManager;

    public class GlaqnaxBloodKnight extends Enemy {

        public function GlaqnaxBloodKnight(path: Vector.<Point>, pathOffset: Point, timeOffset: Number, boost: Number = 1.0) {
            super(Context.newImage(Images.ENEMY_GLAQNAX_BLOOD_KNIGHT), SoundManager.DEATH_BLOOD_KNIGHT, 65, 7, path, pathOffset, timeOffset, 0.95, boost);
        }

    }
}
