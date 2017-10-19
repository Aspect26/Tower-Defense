package td.states {

    import starling.display.Image;

    import td.buildings.Tower;
    import td.constants.Colors;
    import td.map.Map;
import td.utils.Position;
import td.utils.draw.Primitive;

    public class BuyingTowerState extends State {

        private var tower: Tower;
        private var towerImage: Image;
        private var towerOccupationOverlay: Primitive;

        public function BuyingTowerState(tower: Tower) {
            this.tower = tower;
            this.towerImage = tower.getNewImage();
            this.towerOccupationOverlay = new Primitive();
            this.towerOccupationOverlay.rectangle(0, 0, tower.getSize().width * Map.TILE_SIZE, tower.getSize().height * Map.TILE_SIZE, Colors.PRIMARY, 0, 0, 0.25);
        }

        public function getTower(): Tower {
            return this.tower
        }

        public function getTowerImage(): Image {
            return this.towerImage;
        }

        public function getTowerOverlay(): Primitive {
            return this.towerOccupationOverlay;
        }

        public function setPosition(position: Position): void {
            towerImage.x = position.x;
            towerImage.y = position.y;
            towerOccupationOverlay.x = position.x;
            towerOccupationOverlay.y = position.y;
        }

    }

}
