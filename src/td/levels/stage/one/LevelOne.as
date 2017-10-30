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

            map.setRectangleOccupied(5, 0, 6, 19);
            map.setRectangleOccupied(11, 13, 25, 6);
            map.setRectangleOccupied(30, 19, 6, 7);

            return map;
        }

        protected override function createEnemies(): Vector.<Enemy> {
            var enemies: Vector.<Enemy> = Vector.<Enemy>([]);
            var path: Vector.<Point> = this.getEnemyPath();
            var pathOffset: Point = this.getPathOffset();

            addWave(enemies, 5.0, path, pathOffset, 3, 0, 0);

            addWave(enemies, 35.0, path, pathOffset, 6, 0, 0);

            addWave(enemies, 70.0, path, pathOffset, 10, 1, 0);

            addWave(enemies, 115.0, path, pathOffset, 25, 3, 0);

            addWave(enemies, 180.0, path, pathOffset, 15, 20, 5);

            addWave(enemies, 270.0, path, pathOffset, 20, 15, 10);

            addWave(enemies, 360.0, path, pathOffset, 50, 30, 25);

            return enemies;
        }

    }

}
