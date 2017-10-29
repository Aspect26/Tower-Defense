package td.ui {
    import td.buildings.TowerDescriptor;

    public class NewTowerButton extends ImageButton {

        private static const SIZE: int = 70;

        private var towerDescriptor: TowerDescriptor;

        public function NewTowerButton(towerDescriptor: TowerDescriptor, x: int, y: int, onClick: Function) {
            super(towerDescriptor.getImagePath(), x, y, SIZE, SIZE, onClick);
            this.towerDescriptor = towerDescriptor;
        }

        public function getTowerDescriptor(): TowerDescriptor {
            return this.towerDescriptor;
        }

    }

}
