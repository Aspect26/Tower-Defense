package td.buildings {
    import td.levels.Level;
    import td.utils.Size;

    public class TowerDescriptor {

        private var imagePath: String;
        private var missiliImagePath: String;
        private var cost: int;
        private var size: Size;
        private var damage: int;
        private var range: int;
        private var cooldown: Number;
        private var towerClass: Class;

        public function TowerDescriptor(towerClass: Class, cost: int, size: Size, damage: int, range: int, cooldown: Number, imagePath: String, missileImagePath: String) {
            this.towerClass = towerClass;
            this.cost = cost;
            this.size = size;
            this.damage = damage;
            this.range = range;
            this.cooldown = cooldown;
            this.imagePath = imagePath;
            this.missiliImagePath = missileImagePath;
        }

        public function getImagePath(): String {
            return this.imagePath;
        }

        public function getMissileImagePath(): String {
            return this.missiliImagePath;
        }

        public function getCost(): int {
            return this.cost;
        }

        public function getDamage(): int {
            return this.damage;
        }

        public function getRange(): int {
            return this.range;
        }

        public function getCooldown(): Number {
            return this.cooldown;
        }

        public function getSize(): Size {
            return this.size;
        }

        public function getNewInstance(level: Level): Tower {
            return new towerClass(level);
        }

    }

}
