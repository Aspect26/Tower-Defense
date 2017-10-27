package td.levels {
    import td.enemies.Enemy;

    public class LevelEnemyData {

        public var enemy: Enemy;
        public var startTime: int;

        public function LevelEnemyData(enemy: Enemy, startTime: int) {
            this.enemy = enemy;
            this.startTime = startTime;
        }

    }

}
