package td.levels.stage.one {

    import flash.geom.Point;

    import td.enemies.Enemy;
    import td.enemies.Glaq;
    import td.levels.*;
    import td.Context;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelOne extends Level {

        [Embed(source="../../../../assets/levels/stage1/level1.tmx", mimeType="application/octet-stream")]
        protected const mapFile: Class;

        public function LevelOne() {
            super(Context.text(TextIds.Stage1Level1Intro));
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

            enemies.push(new Glaq(path, pathOffset, 1.0));
            enemies.push(new Glaq(path, pathOffset, 3.0));
            enemies.push(new Glaq(path, pathOffset, 5.0));
            enemies.push(new Glaq(path, pathOffset, 7.0));
            enemies.push(new Glaq(path, pathOffset, 9.0));

            return enemies;
        }

    }

}
