package td.enemies {
    import flash.geom.Point;

    import td.Context;
    import td.constants.Images;
    import td.music.SoundManager;

    public class SpawnOfZax extends Enemy {

        public function SpawnOfZax(path: Vector.<Point>, pathOffset: Point, timeOffset: Number, boost: Number = 1.0) {
            super(Context.newImage(Images.ENEMY_SPAWN_OF_ZAX), SoundManager.DEATH_SPAWN, 28, 5, path, pathOffset, timeOffset, 1.3, boost);
        }

    }
}
