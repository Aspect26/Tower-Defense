package td.player {
    import flash.net.SharedObject;

    public class Player {

        private var currentLevel: int;
        private const saveFile: String = "td.save";

        public function Player() {

        }

        public function finishedLevel(level: int): void {
            if (level == currentLevel) {
                this.currentLevel++;
                this.save();
            }
        }

        public function getUnlockedLevels(): int {
            return this.currentLevel;
        }

        public function save(): void {
            var saveDataObject: SharedObject = SharedObject.getLocal(this.saveFile);
            saveDataObject.data.currentLevel = this.currentLevel;
            saveDataObject.flush();
        }

        public function load(): void {
            var saveDataObject: SharedObject = SharedObject.getLocal(this.saveFile);
            this.currentLevel = saveDataObject.data.currentLevel;

            if (this.currentLevel < 1) {
                this.currentLevel = 1;
            }
        }

    }

}
