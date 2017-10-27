package td.levels.stage.one {

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

        protected override function createEnemies(): Vector.<LevelEnemyData> {
            var enemies: Vector.<LevelEnemyData> = Vector.<LevelEnemyData>([]);

            enemies.push(new LevelEnemyData(new Glaq(this.getEnemyPath(), this.getPathOffset()), 1));

            return enemies;
        }

    }

}
