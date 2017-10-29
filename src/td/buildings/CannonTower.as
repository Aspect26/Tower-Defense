package td.buildings {

    import td.constants.Images;
    import td.levels.Level;
    import td.utils.Size;

    public class CannonTower extends Tower {

        public function CannonTower(level: Level) {
            super(CannonTower.getDescriptor(), level);
        }

        public static function getDescriptor(): TowerDescriptor {
            return new TowerDescriptor(CannonTower, 100, new Size(5, 5), 30, 130, 2.0, Images.TOWER_CANNON, Images.MISSILE_CANNON_TOWER);
        }

    }

}
