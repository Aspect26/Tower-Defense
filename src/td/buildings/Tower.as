package td.buildings {

    import flash.geom.Point;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import td.Context;
    import td.enemies.Enemy;
    import td.levels.Level;
    import td.map.Map;
    import td.utils.Size;
    import td.utils.draw.ImageUtils;

    public class Tower extends Sprite implements IAnimatable {

        private var image: Image;
        private var imagePath: String;
        private var missileImagePath: String;

        private var damage: int;
        private var cost: int;
        private var cooldawn: Number;
        private var range: Number;
        private var size: Size;
        private var level: Level;
        private var position: Point;

        private var currentCooldown: Number;

        public function Tower(towerDescriptor: TowerDescriptor, level: Level) {
            this.cost = towerDescriptor.getCost();
            this.imagePath = towerDescriptor.getImagePath();
            this.missileImagePath = towerDescriptor.getMissileImagePath();
            this.image = Context.newImage(imagePath);
            this.damage = towerDescriptor.getDamage();
            this.cooldawn = towerDescriptor.getCooldown();
            this.size = towerDescriptor.getSize();
            this.range = towerDescriptor.getRange();
            this.level = level;
            this.currentCooldown = 0;

            ImageUtils.resize(this.image, this.size.width * Map.TILE_SIZE, this.size.height * Map.TILE_SIZE);
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event = null): void {
            // TODO: visualize ranges
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            Starling.juggler.add(this);
            this.addChild(this.image);
            this.x = position.x;
            this.y = position.y;
        }

        public function getSize(): Size {
            return this.size;
        }

        public function getCost(): int {
            return this.cost;
        }

        public function getImagePath(): String {
            return this.imagePath;
        }

        public function getMissileImage(): Image {
            return Context.newImage(this.missileImagePath);
        }

        public function setPosition(position: Point): void {
            this.position = position;
            this.x = position.x;
            this.y = position.y;
        }

        public function advanceTime(deltaTime: Number): void {
            if (this.currentCooldown > 0) {
                this.currentCooldown -= deltaTime;
            } else {
                var enemies: Vector.<Enemy> = this.level.getEnemies();
                var nearestEnemy: Enemy = null;
                var nearestEnemyDistance: Number = this.range + 1;
                for (var i: int = 0; i < enemies.length; ++i) {
                    var enemy: Enemy = enemies[i];
                    if (!enemy.isAlive()) {
                        continue;
                    }
                    var enemyDistance: int = enemy.getDistanceFrom(this.position);
                    if (enemyDistance < nearestEnemyDistance) {
                        nearestEnemy = enemy;
                        nearestEnemyDistance = enemyDistance;
                    }
                }
                if (nearestEnemy) {
                    this.currentCooldown = cooldawn;
                    this.level.createMissile(this, nearestEnemy);
                }
            }
        }
    }

}
