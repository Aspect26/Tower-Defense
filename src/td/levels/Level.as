package td.levels {
    import flash.geom.Point;

    import io.arkeus.tiled.TiledMap;
    import io.arkeus.tiled.TiledObjectLayer;

    import td.buildings.Tower;
    import td.enemies.Enemy;
    import td.map.Map;
    import td.screens.LevelScreen;
    import td.utils.Position;
    import td.utils.draw.Primitive;

    public class Level {

        private var map: Map;
        private var enemies: Vector.<Enemy>;
        private var introText: String;
        private var actualMoney: int;

        private var screen: LevelScreen;

        public function Level(introText: String, startMoney: int = 50) {
            this.map = this.createMap();
            this.enemies = this.createEnemies();
            this.introText = introText;
            this.actualMoney = startMoney;
        }

        protected virtual function createMap(): Map {
            throw new Error("The class Level is abstract and should not be instantiated!");
        }

        protected virtual function createEnemies(): Vector.<Enemy> {
            throw new Error("The class Level is abstract and should not be instantiated!");
        }

        public function getEnemies(): Vector.<Enemy> {
            return this.enemies;
        }

        public function getIntroText(): String {
            return this.introText;
        }

        public function getOccupationOverlay(): Primitive {
            return this.map.getOccupationOverlay();
        }

        public function getMoney(): int {
            return this.actualMoney;
        }

        public function getMap(): Map {
            return this.map;
        }

        public function getEnemyPath(): Vector.<Point> {
            // TODO: cache this function
            var map: TiledMap = this.map.getMapData();
            for (var layerIndex: int = 0; layerIndex < map.layers.getAllLayers().length; ++layerIndex) {
                var layer: TiledObjectLayer = map.layers.layers[layerIndex] as TiledObjectLayer;
                if (layer == null) {
                    continue;
                }
                return layer.getObjectByIndex(0).points;
            }
            return null;
        }

        public function getPathOffset(): Point {
            // TODO: cache this function
            var map: TiledMap = this.map.getMapData();
            for (var layerIndex: int = 0; layerIndex < map.layers.getAllLayers().length; ++layerIndex) {
                var layer: TiledObjectLayer = map.layers.layers[layerIndex] as TiledObjectLayer;
                if (layer == null) {
                    continue;
                }
                return new Point(layer.getObjectByIndex(0).x, layer.getObjectByIndex(0).y);
            }
            return null;
        }

        public function setScreen(screen: LevelScreen): void {
            this.screen = screen;
        }

        public function addTower(tower: Tower, position: Position): Boolean {
            if (this.map.addTower(tower, position)) {
                this.addMoney(-tower.getCost());
                return true;
            }

            return false;
        }

        public function addMoney(money: int): void {
            this.actualMoney += money;
            this.screen.setMoney(this.actualMoney);
        }

    }

}
