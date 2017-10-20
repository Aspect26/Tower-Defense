package td.levels {
import td.buildings.Tower;
import td.map.Map;
import td.utils.Position;
import td.utils.draw.Primitive;

public class Level {

        private var map: Map;
        private var backgroundPath: String;
        private var introText: String;

        public function Level(backgroundPath: String, introText: String) {
            this.map = this.createMap();
            this.backgroundPath = backgroundPath;
            this.introText = introText;
        }

        protected virtual function createMap(): Map {
            return new Map();
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

        public function addTower(tower: Tower, position: Position): Boolean {
            return this.map.addTower(tower, position);
        }

    }

}
