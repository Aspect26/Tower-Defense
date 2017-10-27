package td.levels.stage.one {

    import td.levels.*;
    import td.Context;
    import td.constants.Images;
    import td.constants.TextIds;
    import td.map.Map;

    public class LevelThree extends Level {

        [Embed(source="../../../../assets/levels/stage1/level3.tmx", mimeType="application/octet-stream")]
        protected const mapFile: Class;

        public function LevelThree() {
            super(Context.text(TextIds.Stage1Level3Intro));
        }

        protected override function createMap(): Map {
            var map: Map = new Map(this.mapFile);

            map.setRectangleOccupied(34, 0, 4, 7);
            map.setRectangleOccupied(4, 3, 30, 4);
            map.setRectangleOccupied(4, 7, 4, 8);
            map.setRectangleOccupied(8, 11, 27, 4);
            map.setRectangleOccupied(31, 15, 4, 7);
            map.setRectangleOccupied(17, 18, 14, 4);
            map.setRectangleOccupied(0, 19, 17, 4);
            map.setRectangleOccupied(17, 22, 2, 1);

            return map;
        }

    }

}
