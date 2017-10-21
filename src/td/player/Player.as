package td.player {

    public class Player {

        private var currentLevel: int = 1;

        public function Player() {

        }

        public function finishedLevel(level: int): void {
            if (level == currentLevel) {
                this.currentLevel ++;
            }
        }

        public function getUnlockedLevels(): int {
            return this.currentLevel;
        }

    }

}
