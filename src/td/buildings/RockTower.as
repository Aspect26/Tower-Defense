package td.buildings {
    import td.constants.Images;
    import td.levels.Level;
    import td.utils.Size;

    public class RockTower extends Tower {

        public function RockTower(level: Level) {
            super(RockTower.getDescriptor(), level);
        }

        public static function getDescriptor(): TowerDescriptor {
            return new TowerDescriptor(RockTower, 40, new Size(5, 5), 15, 130, 1.3, Images.TOWER_ROCK, Images.MISSILE_ROCK_TOWER);
        }
    }

}
