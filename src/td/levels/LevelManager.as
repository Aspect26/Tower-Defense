package td.levels {
import td.levels.stage.one.LevelOne;
    import td.levels.stage.one.LevelThree;
    import td.levels.stage.one.LevelTwo;

    public class LevelManager {

        public function LevelManager() {
        }

        public static function createLevel(level: int): Level {
            switch (level) {
                case 1:
                    return new td.levels.stage.one.LevelOne(); break;
                case 2:
                    return new td.levels.stage.one.LevelTwo(); break;
                case 3:
                    return new td.levels.stage.one.LevelThree(); break;
                default:
                    return new td.levels.stage.one.LevelOne(); break;
            }
        }

    }

}
