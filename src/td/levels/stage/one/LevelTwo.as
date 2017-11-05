package td.levels.stage.one {

    import flash.geom.Point;

    import td.enemies.Enemy;
    import td.levels.*;
    import td.Context;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelTwo extends Level {

        [Embed(source="../../../../assets/levels/stage1/level2.tmx", mimeType="application/octet-stream")]
        protected const mapFile: Class;

        public function LevelTwo() {
            super(2, Context.text(TextIds.Stage1Level2Intro));
        }

        protected override function createMap(): Map {
            var map: Map = new Map(this.mapFile);

            // PATH
            map.setRectangleOccupied(0, 11, 11, 5);
            map.setRectangleOccupied(6, 2, 5, 9);
            map.setRectangleOccupied(11, 2, 17, 5);
            map.setRectangleOccupied(23, 7, 5, 16);
            map.setRectangleOccupied(28, 18, 12, 5);

            // PROPS
            map.setRectangleOccupied(0, 0, 38, 2);
            map.setRectangleOccupied(38, 1, 2, 14);
            map.setRectangleOccupied(0, 23, 40, 2);
            map.setRectangleOccupied(0, 19, 2, 4);
            map.setRectangleOccupied(0, 2, 2, 6);

            map.setRectangleOccupied(36, 2, 2, 6);
            map.setRectangleOccupied(2, 20, 14, 3);

            return map;
        }

        protected override function createEnemies(): Vector.<Enemy> {
            var enemies: Vector.<Enemy> = Vector.<Enemy>([]);
            var path: Vector.<Point> = this.getEnemyPath();
            var pathOffset: Point = this.getPathOffset();

            addWave(enemies, 5.0, path, pathOffset, 3);

            addWave(enemies, 25.0, path, pathOffset, 4);

            addWave(enemies, 40.0, path, pathOffset, 4, 1);

            addWave(enemies, 60.0, path, pathOffset, 7, 2);

            addWave(enemies, 85.0, path, pathOffset, 10, 3);

            addWave(enemies, 120.0, path, pathOffset, 0, 6);

            addWave(enemies, 150.0, path, pathOffset, 0, 10);

            addWave(enemies, 180.0, path, pathOffset, 0, 15);

            addWave(enemies, 220.0, path, pathOffset, 20, 0, 0, 0.6);

            addWave(enemies, 260.0, path, pathOffset, 10, 10, 0, 0.8);

            addWave(enemies, 300.0, path, pathOffset, 0, 20, 0, 0.8);

            addWave(enemies, 345.0, path, pathOffset, 0, 25, 0, 0.8);

            addWave(enemies, 390.0, path, pathOffset, 0, 20, 0, 0.3);

            addWave(enemies, 430.0, path, pathOffset, 0, 30, 0, 0.3);

            addWave(enemies, 465.0, path, pathOffset, 0, 45, 0, 0.3);

            return enemies;
        }

    }

}
