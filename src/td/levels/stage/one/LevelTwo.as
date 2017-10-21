package td.levels.stage.one {

    import td.levels.*;
    import td.Context;
    import td.constants.Images;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelTwo extends Level {

        public function LevelTwo() {
            super(Images.S1L2_BACKGROUND, Context.text(TextIds.Stage1Level2Intro));
        }

        protected override function createMap(): Map {
            var map: Map = new Map();

            map.setRectangleOccupied(0, 11, 11, 5);
            map.setRectangleOccupied(6, 2, 5, 9);
            map.setRectangleOccupied(11, 2, 17, 5);
            map.setRectangleOccupied(23, 7, 5, 16);
            map.setRectangleOccupied(28, 18, 12, 5);

            return map;
        }

    }

}
