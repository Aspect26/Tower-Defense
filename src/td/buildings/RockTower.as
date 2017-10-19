package td.buildings {
import td.constants.Images;
import td.utils.Size;

public class RockTower extends Tower {

        public function RockTower() {
            super(Images.TOWER_ROCK, 15, 1.3, new Size(5, 5));
        }
    }

}
