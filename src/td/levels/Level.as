package td.levels {
    import flash.geom.Point;

    import io.arkeus.tiled.TiledMap;
    import io.arkeus.tiled.TiledObjectLayer;

    import starling.events.EventDispatcher;

    import td.Context;

    import td.buildings.Tower;
    import td.enemies.Enemy;
    import td.enemies.Glaq;
    import td.enemies.GlaqnaxBloodKnight;
    import td.enemies.SpawnOfZax;
    import td.events.LevelFinishedEvent;
    import td.map.Map;
    import td.missiles.SimpleMissile;
    import td.music.SoundManager;
    import td.screens.LevelScreen;
    import td.utils.draw.Primitive;

    public class Level {

        private var levelNumber: int;
        private var map: Map;
        private var enemies: Vector.<Enemy>;
        private var introText: String;
        private var actualMoney: int;
        private var remainingEnemies: int;

        private var screen: LevelScreen;

        public function Level(levelNumber: int, introText: String, startMoney: int = 50) {
            this.levelNumber = levelNumber;
            this.map = this.createMap();
            this.enemies = this.createEnemies();
            this.remainingEnemies = this.enemies.length;
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

        public function getLevelNumber(): int {
            return this.levelNumber;
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

        public function addTower(tower: Tower, position: Point): Boolean {
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

        public function killEnemy(enemy: Enemy): void {
            this.addMoney(enemy.getMoneyReward());
            this.remainingEnemies--;
            if (this.remainingEnemies == 0) {
                this.screen.dispatchEvent(new LevelFinishedEvent(true, this.levelNumber));
            }
        }

        public function createMissile(source: Tower, target: Enemy): void {
            var missile: SimpleMissile = new SimpleMissile(new Point(source.x + source.width / 2, source.y + source.height / 2), source, target, source.getMissileImage());
            Context.soundManager.playSound(source.getMissileSound());
            this.screen.addMissile(missile);
        }

        public static function addGlaqs(enemies: Vector.<Enemy>, startTime: Number, count: int, path: Vector.<Point>, pathOffset: Point): void {
            for (var i: int = 0; i < count; ++i) {
                enemies.push(new Glaq(path, pathOffset, startTime + i * 2));
            }
        }

        public static function addSpawnsOfZax(enemies: Vector.<Enemy>, startTime: Number, count: int, path: Vector.<Point>, pathOffset: Point): void {
            for (var i: int = 0; i < count; ++i) {
                enemies.push(new SpawnOfZax(path, pathOffset, startTime + i * 2));
            }
        }

        public static function addGlaqnaxxBloodKnights(enemies: Vector.<Enemy>, startTime: Number, count: int, path: Vector.<Point>, pathOffset: Point): void {
            for (var i: int = 0; i < count; ++i) {
                enemies.push(new GlaqnaxBloodKnight(path, pathOffset, startTime + i * 2));
            }
        }

        public static function addWave(enemies: Vector.<Enemy>, startTime: Number, path: Vector.<Point>, pathOffset: Point, glaqs: int, spawns: int, bloodKnights: int): void {
            var currentTime: int = startTime;
            for (var i: int = 0; i < spawns; ++i, currentTime += 2) {
                enemies.push(new SpawnOfZax(path, pathOffset, currentTime));
            }

            for (i = 0; i < glaqs; ++i, currentTime += 1.2) {
                enemies.push(new Glaq(path, pathOffset, currentTime));
            }

            for (i = 0; i < bloodKnights; ++i, currentTime += 2) {
                enemies.push(new GlaqnaxBloodKnight(path, pathOffset, currentTime));
            }
        }

    }

}
