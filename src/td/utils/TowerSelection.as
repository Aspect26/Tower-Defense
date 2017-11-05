package td.utils {
    import starling.display.Sprite;
    import starling.events.TouchEvent;

    import td.buildings.Tower;
    import td.constants.Images;
    import td.events.TowerRemoveRequest;
    import td.particles.SelectionParticles;
    import td.ui.ImageButton;

    public class TowerSelection extends Sprite {

        private var tower: Tower;

        private var particles: SelectionParticles;
        private var removeButton: ImageButton;

        public function TowerSelection() {
            this.particles = new SelectionParticles();
            this.particles.scale = 0.2;
            this.particles.start();

            this.removeButton = new ImageButton(Images.CROSS, 0, 0, 30, 30, onRemoveClicked, true);
        }

        public function select(tower: Tower): void {
            this.tower = tower;

            this.particles.x = tower.x + tower.width / 2;
            this.particles.y = tower.y + tower.height / 2;
            this.addChild(this.particles);

            this.removeButton.x = tower.x + tower.width;
            this.removeButton.y = tower.y - 20;
            this.addChild(this.removeButton);
        }

        public function unselect(): void {
            if (this.tower != null) {
                this.tower = null;
                this.removeChild(particles);
                this.removeChild(removeButton);
            }
        }

        private function onRemoveClicked(event: TouchEvent): void {
            this.dispatchEvent(new TowerRemoveRequest(this.tower));
        }

    }

}
