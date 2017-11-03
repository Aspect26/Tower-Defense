package td.buildings {

    import td.constants.Images;
    import td.levels.Level;
    import td.music.SoundManager;
    import td.utils.Size;

    public class CannonTower extends Tower {

        public function CannonTower(level: Level) {
            super(CannonTower.getDescriptor(), level);
        }

        public static function getDescriptor(): TowerDescriptor {
            return new TowerDescriptor(CannonTower, 100, new Size(3, 3), 10, 150, 2.0, Images.TOWER_CANNON,
                    Images.MISSILE_CANNON_TOWER, SoundManager.SHOT_3);
        }

    }

}
