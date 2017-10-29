package td.enemies {
    import flash.geom.Point;

    import td.Context;
    import td.constants.Images;

    public class SpawnOfZax extends Enemy {

        public function SpawnOfZax(path: Vector.<Point>, pathOffset: Point, timeOffset: Number) {
            super(Context.newImage(Images.ENEMY_SPAWN_OF_ZAX), 15, 15, path, pathOffset, timeOffset, 1.3);
        }

    }
}
