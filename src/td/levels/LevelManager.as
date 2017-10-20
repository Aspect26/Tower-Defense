package td.levels {
import td.levels.stage.one.LevelOne;

public class LevelManager {

        public function LevelManager() {
        }

        public static function createLevel(level: int): Level {
            switch (level) {
                case 1:
                    return new td.levels.stage.one.LevelOne();
                default:
                    return new td.levels.stage.one.LevelOne();
            }
        }

    }

}
