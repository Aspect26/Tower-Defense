package td.states {

    import starling.display.Image;

    import td.Context;
    import td.buildings.Tower;
    import td.buildings.TowerDescriptor;
    import td.constants.Colors;
    import td.levels.Level;
    import td.map.Map;
    import td.utils.draw.ImageUtils;
    import td.utils.draw.Primitive;

    public class BuyingTowerState extends State {

        private var towerDescriptor: TowerDescriptor;
        private var towerImage: Image;
        private var towerOccupationOverlay: Primitive;

        public function BuyingTowerState(towerDescriptor: TowerDescriptor) {
            this.towerDescriptor = towerDescriptor;
            this.towerOccupationOverlay = new Primitive();
            this.towerOccupationOverlay.rectangle(0, 0, towerDescriptor.getSize().width * Map.TILE_SIZE, towerDescriptor.getSize().height * Map.TILE_SIZE, Colors.PRIMARY, 0, 0, 0.25);
            this.towerImage = Context.newImage(towerDescriptor.getImagePath());
            ImageUtils.resize(this.towerImage, towerDescriptor.getSize().width * Map.TILE_SIZE, towerDescriptor.getSize().height * Map.TILE_SIZE);
        }

        public function getTowerOverlay(): Primitive {
            return this.towerOccupationOverlay;
        }

        public function getTowerDescriptor(): TowerDescriptor {
            return this.towerDescriptor;
        }

        public function getTowerImage(): Image {
            return this.towerImage;
        }

        public function setPosition(x: int, y: int): void {
            this.towerImage.x = x;
            this.towerImage.y = y;
            this.towerOccupationOverlay.x = x;
            this.towerOccupationOverlay.y = y;
        }

        public function instantiateTower(level: Level): Tower {
            return this.towerDescriptor.getNewInstance(level);
        }

    }

}
