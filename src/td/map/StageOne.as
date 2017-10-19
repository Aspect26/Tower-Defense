package td.map {

    public class StageOne {

        public function StageOne() {
        }

        public static function getLevelOneMap(): Map {
            var map: Map = new Map();

            map.setRectangleOccupied(5, 0, 6, 19);
            map.setRectangleOccupied(11, 13, 25, 6);
            map.setRectangleOccupied(30, 19, 6, 7);

            return map;
        }

        public static function getLevelTwoMap(): Map {
            return new Map();
        }

        public static function getLevelThreeMap(): Map {
            return new Map();
        }

    }

}
