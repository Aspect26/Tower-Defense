package td.utils {
    import flash.geom.Point;

    public class VectorUtils {

        public static function getNormalizedDirection(_from: Point, _to: Point, _normalizeBy: Number): Point {
            var vector: Point = _to.subtract(_from);
            vector.normalize(_normalizeBy);

            return vector;
        }

    }

}
