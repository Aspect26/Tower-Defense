package td.ui {
    import td.buildings.Tower;

    public class NewTowerButton extends ImageButton {

        private static const SIZE: int = 70;

        private var tower: Tower;

        public function NewTowerButton(tower: Tower, x: int, y: int, onClick: Function) {
            super(tower.getImagePath(), x, y, SIZE, SIZE, onClick);
            this.tower = tower;
        }

        public function getNewTower(): Tower {
            // TO DO: we need a new object
            return tower;
        }

    }

}
