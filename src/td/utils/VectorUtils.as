package td.utils {
    import flash.geom.Point;

    public class VectorUtils {

        public static function getNormalizedDirection(result: Point, from_x: int, from_y: int, to_x: int, to_y: int, _normalizeBy: Number): void {
            result.x = to_x - from_x;
            result.y = to_y - from_y;
            result.normalize(_normalizeBy);
        }

    }

}
