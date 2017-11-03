package td.buildings {
    import td.constants.Images;
    import td.levels.Level;
    import td.music.SoundManager;
    import td.utils.Size;

    public class RockTower extends Tower {

        public function RockTower(level: Level) {
            super(RockTower.getDescriptor(), level);
        }

        public static function getDescriptor(): TowerDescriptor {
            return new TowerDescriptor(RockTower, 50, new Size(3, 3), 5, 130, 1.3, Images.TOWER_ROCK,
                    Images.MISSILE_ROCK_TOWER, SoundManager.SHOT_2);
        }
    }

}
