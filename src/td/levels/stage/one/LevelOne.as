package td.levels.stage.one {

    import flash.geom.Point;

    import td.enemies.Enemy;
    import td.levels.*;
    import td.Context;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelOne extends Level {

        [Embed(source="../../../../assets/levels/stage1/level1.tmx", mimeType="application/octet-stream")]
        protected const mapFile: Class;

        public function LevelOne() {
            super(1, Context.text(TextIds.Stage1Level1Intro));
        }

        protected override function createMap(): Map {
            var map: Map = new Map(this.mapFile);

            // PATH
            map.setRectangleOccupied(5, 0, 6, 19);
            map.setRectangleOccupied(11, 13, 25, 6);
            map.setRectangleOccupied(30, 19, 6, 7);

            // PROPS
            map.setRectangleOccupied(0, 0, 2, 24);
            map.setRectangleOccupied(13, 0, 26, 2);
            map.setRectangleOccupied(38, 2, 2, 10);
            map.setRectangleOccupied(2, 23, 26, 2);

            map.setRectangleOccupied(24, 2, 14, 2);
            map.setRectangleOccupied(28, 4, 10, 3);
            map.setRectangleOccupied(34, 7, 4, 2);
            map.setRectangleOccupied(2, 20, 2, 3);

            return map;
        }

        protected override function createEnemies(): Vector.<Enemy> {
            var enemies: Vector.<Enemy> = Vector.<Enemy>([]);
            var path: Vector.<Point> = this.getEnemyPath();
            var pathOffset: Point = this.getPathOffset();

            addWave(enemies, 5.0, path, pathOffset, 2);

            addWave(enemies, 18.0, path, pathOffset, 3);

            addWave(enemies, 33.0, path, pathOffset, 3, 1);

            addWave(enemies, 50.0, path, pathOffset, 5, 1);

            addWave(enemies, 66.0, path, pathOffset, 7, 1);

            addWave(enemies, 86.0, path, pathOffset, 3, 2);

            addWave(enemies, 101.0, path, pathOffset, 0, 4);

            addWave(enemies, 120.0, path, pathOffset, 15, 0);

            addWave(enemies, 150.0, path, pathOffset, 10, 5);

            addWave(enemies, 180.0, path, pathOffset, 5, 15);

            addWave(enemies, 225.0, path, pathOffset, 5, 25);

            addWave(enemies, 290.0, path, pathOffset, 0, 40);

            return enemies;
        }

    }

}
