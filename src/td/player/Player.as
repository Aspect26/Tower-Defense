package td.player {

    public class Player {

        // TODO: change on release to 1
        private var currentLevel: int = 2;

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
