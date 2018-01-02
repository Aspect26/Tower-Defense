package td.levels.stage.one {

    import flash.geom.Point;

    import td.enemies.Enemy;
    import td.levels.*;
    import td.Context;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelThree extends Level {

        [Embed(source="../../../../assets/levels/stage1/level3.tmx", mimeType="application/octet-stream")]
        protected const mapFile: Class;

        public function LevelThree() {
            super(3, Context.text(TextIds.Stage1Level3Intro), 50);
        }

        protected override function createMap(): Map {
            var map: Map = new Map(this.mapFile);

            // PATH
            map.setRectangleOccupied(34, 0, 4, 7);
            map.setRectangleOccupied(4, 3, 30, 4);
            map.setRectangleOccupied(4, 7, 4, 8);
            map.setRectangleOccupied(8, 11, 27, 4);
            map.setRectangleOccupied(31, 15, 4, 3);
            map.setRectangleOccupied(0, 18, 35, 4);

            // PROPS
            map.setRectangleOccupied(38, 0, 2, 24);
            map.setRectangleOccupied(36, 7, 2, 15);
            map.setRectangleOccupied(36, 23, 2, 2);

            return map;
        }

        protected override function createEnemies(): Vector.<Enemy> {
            var enemies: Vector.<Enemy> = Vector.<Enemy>([]);
            var path: Vector.<Point> = this.getEnemyPath();
            var pathOffset: Point = this.getPathOffset();

            addWave(enemies, 5.0, path, pathOffset, 4);

            addWave(enemies, 25.0, path, pathOffset, 5);

            addWave(enemies, 44.0, path, pathOffset, 7);

            addWave(enemies, 69.0, path, pathOffset, 7, 3);

            addWave(enemies, 94.0, path, pathOffset, 10);

            addWave(enemies, 121, path, pathOffset, 10, 0, 0, 0.6);

            addWave(enemies, 146, path, pathOffset, 10, 5, 0, 0.6);

            addWave(enemies, 181, path, pathOffset, 0, 12, 0, 0.6, 1.5);

            addWave(enemies, 224, path, pathOffset, 0, 19, 0, 0.6, 1.5);

            addWave(enemies, 281, path, pathOffset, 9, 9, 0, 0.3, 1.5);

            addWave(enemies, 326, path, pathOffset, 15, 13, 0, 0.3, 1.5);

            addWave(enemies, 376, path, pathOffset, 0, 29, 0, 0.3, 1.5);

            addWave(enemies, 436, path, pathOffset, 18, 11, 5, 0.2, 1.5);

            addWave(enemies, 508, path, pathOffset, 0, 20, 0, 0.2, 1.5);

            addWave(enemies, 558, path, pathOffset, 0, 20, 7, 0.2, 1.5);

            addWave(enemies, 628, path, pathOffset, 27, 12, 5, 0.1, 1.5);

            addWave(enemies, 698, path, pathOffset, 0, 18, 0, 0.1, 1.5);

            addWave(enemies, 745,  path, pathOffset, 30, 15, 5, 0.1, 1.5);

            addWave(enemies, 810, path, pathOffset, 25, 17, 6, 0.1, 1.5);

            addWave(enemies, 880, path, pathOffset, 0, 0, 7, 0.1, 2.0);

            return enemies;
        }

    }

}
