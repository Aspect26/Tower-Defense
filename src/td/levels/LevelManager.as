package td.levels {
import td.levels.stage.one.LevelOne;
    import td.levels.stage.one.LevelThree;
    import td.levels.stage.one.LevelTwo;
    import td.levels.stage.two.LevelOne;
    import td.levels.stage.two.LevelThree;
    import td.levels.stage.two.LevelTwo;

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
                case 4:
                    return new td.levels.stage.two.LevelOne(); break;
                case 5:
                    return new td.levels.stage.two.LevelTwo(); break;
                case 6:
                    return new td.levels.stage.two.LevelThree(); break;
                default:
                    return new td.levels.stage.one.LevelOne(); break;
            }
        }

    }

}
