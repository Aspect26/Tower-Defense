package td.levels.stage.two {

    import flash.geom.Point;

    import td.enemies.Enemy;
    import td.levels.*;
    import td.Context;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelTwo extends Level {

        [Embed(source="../../../../assets/levels/stage2/level2.tmx", mimeType="application/octet-stream")]
        protected const mapFile: Class;

        public function LevelTwo() {
            super(5, Context.text(TextIds.Stage1Level1Intro));
        }

        protected override function createMap(): Map {
            var map: Map = new Map(this.mapFile);

            return map;
        }

        protected override function createEnemies(): Vector.<Enemy> {
            var enemies: Vector.<Enemy> = Vector.<Enemy>([]);
            var path: Vector.<Point> = this.getEnemyPath();
            var pathOffset: Point = this.getPathOffset();

            addWave(enemies, 5.0, path, pathOffset, 3, 0, 0);

            return enemies;
        }

    }

}
