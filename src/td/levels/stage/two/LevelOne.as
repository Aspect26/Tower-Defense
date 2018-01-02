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
            super(1, Context.text(TextIds.Stage1Level1Intro), 80);
        }

        protected override function createMap(): Map {
            var map: Map = new Map(this.mapFile);

            return map;
        }

        protected override function createEnemies(): Vector.<Enemy> {
            var enemies: Vector.<Enemy> = Vector.<Enemy>([]);
            var path: Vector.<Point> = this.getEnemyPath();
            var pathOffset: Point = this.getPathOffset();

            addWave(enemies, 5.0, path, pathOffset, 5, 0, 0);

            addWave(enemies, 20.0, path, pathOffset, 2, 2, 0);

            addWave(enemies, 40.0, path, pathOffset, 3, 4, 0);

            addWave(enemies, 65.0, path, pathOffset, 0, 6, 0, 0.7);

            addWave(enemies, 90.0, path, pathOffset, 0, 5, 2, 0.7);

            addWave(enemies, 120.0, path, pathOffset, 0, 5, 3, 0.7);

            addWave(enemies, 160.0, path, pathOffset, 10, 3, 3, 0.7);

            addWave(enemies, 200.0, path, pathOffset, 10, 0, 0, 0.7, 1.4);

            addWave(enemies, 250.0, path, pathOffset, 10, 3, 2, 0.7, 1.4);

            return enemies;
        }

    }

}
