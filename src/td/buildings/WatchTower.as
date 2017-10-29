package td.buildings {

    import td.constants.Images;
    import td.levels.Level;
    import td.utils.Size;

    public class WatchTower extends Tower {

        public function WatchTower(level: Level) {
            super(WatchTower.getDescriptor(), level);
        }

        public static function getDescriptor(): TowerDescriptor {
            return new TowerDescriptor(WatchTower, 20, new Size(3, 3), 3, 130, 1.5, Images.TOWER_WATCH, Images.MISSILE_WATCH_TOWER);
        }
    }

}
