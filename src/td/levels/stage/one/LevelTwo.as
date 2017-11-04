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
            super(2, Context.text(TextIds.Stage1Level2Intro), 200);
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

            addWave(enemies, 5.0, path, pathOffset, 2, 0, 0);

            return enemies;
        }

    }

}
