package td.buildings {
import td.constants.Images;
import td.utils.Size;

public class CannonTower extends Tower {

        public function CannonTower() {
            super(Images.TOWER_CANNON, 30, 2.0, new Size(5, 5));
        }
    }

}
