package td.levels {
    import td.buildings.Tower;
    import td.map.Map;
    import td.screens.LevelScreen;
    import td.utils.Position;
    import td.utils.draw.Primitive;

    public class Level {

        private var map: Map;
        private var backgroundPath: String;
        private var introText: String;
        private var actualMoney: int;

        private var screen: LevelScreen;

        public function Level(backgroundPath: String, introText: String, startMoney: int = 50) {
            this.map = this.createMap();
            this.backgroundPath = backgroundPath;
            this.introText = introText;
            this.actualMoney = startMoney;
        }

        protected virtual function createMap(): Map {
            throw new Error("The class Level is abstract and should not be instantiated!");
        }

        public function getBackgroundPath(): String {
            return this.backgroundPath;
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
