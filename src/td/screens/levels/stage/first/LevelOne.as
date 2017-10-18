package td.screens.levels.stage.first {
import td.Context;
import td.constants.Images;
import td.constants.TextIds;
import td.screens.levels.LevelScreen;

public class LevelOne extends LevelScreen{

        public function LevelOne() {
            super(Context.text(TextIds.Stage1Level1Intro), Images.S1L1_BACKGROUND);
        }

    }

}
