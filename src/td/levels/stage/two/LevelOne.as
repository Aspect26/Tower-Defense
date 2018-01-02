package td.levels.stage.two {

    import flash.geom.Point;

    import td.enemies.Enemy;
    import td.levels.*;
    import td.Context;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelOne extends Level {

        [Embed(source="../../../../assets/levels/stage2/level1.tmx", mimeType="application/octet-stream")]
        protected const mapFile: Class;

        public function LevelOne() {
            super(4, Context.text(TextIds.Stage2Level1Intro), 80);
        }

        protected override function createMap(): Map {
            var map: Map = new Map(this.mapFile);

            // PATH
            map.setRectangleOccupied(0, 16, 9, 4);
            map.setRectangleOccupied(5, 5, 4, 11);
            map.setRectangleOccupied(9, 5, 31, 4);

            // PROPS
            map.setRectangleOccupied(0, 23, 40, 2);
            map.setRectangleOccupied(38, 13, 2, 10);
            map.setRectangleOccupied(2, 0, 38, 2);
            map.setRectangleOccupied(0, 1, 2, 12);
            map.setRectangleOccupied(16, 21, 20, 2);
            map.setRectangleOccupied(36, 15, 2, 10);
            map.setRectangleOccupied(21, 15, 15, 6);

            return map;
        }

        protected override function createEnemies(): Vector.<Enemy> {
            var enemies: Vector.<Enemy> = Vector.<Enemy>([]);
            var path: Vector.<Point> = this.getEnemyPath();
            var pathOffset: Point = this.getPathOffset();

            addWave(enemies, 5.0, path, pathOffset, 5, 0, 0);

            addWave(enemies, 23.0, path, pathOffset, 2, 2, 0);

            addWave(enemies, 43.0, path, pathOffset, 3, 3, 0);

            addWave(enemies, 68.0, path, pathOffset, 0, 4, 0, 0.7);

            addWave(enemies, 93.0, path, pathOffset, 0, 5, 2, 0.7);

            addWave(enemies, 128.0, path, pathOffset, 0, 5, 3, 0.7);

            addWave(enemies, 168.0, path, pathOffset, 10, 3, 2, 0.7);

            addWave(enemies, 213.0, path, pathOffset, 15, 0, 0, 0.7, 1.4);

            addWave(enemies, 243.0, path, pathOffset, 10, 3, 2, 0.7, 1.4);

            addWave(enemies, 281.0, path, pathOffset, 0, 5, 3, 0.7, 1.4);

            addWave(enemies, 316.0, path, pathOffset, 0, 10, 4, 0.7, 1.4);

            addWave(enemies, 358.0, path, pathOffset, 10, 0, 4, 0.7, 1.4);

            addWave(enemies, 398.0, path, pathOffset, 0, 0, 2, 0.3, 1.7);

            addWave(enemies, 428.0, path, pathOffset, 10, 5, 1, 0.3, 1.7);

            addWave(enemies, 458.0, path, pathOffset, 17, 0, 0, 0.3, 2.0);

            return enemies;
        }

    }

}
