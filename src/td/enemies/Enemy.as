package td.enemies {
    import flash.geom.Point;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    public class Enemy extends Sprite implements IAnimatable {

        private static const NEW_PATH_POINT_LAMBDA: Number = 3;

        private var image: Image;
        private var path: Vector.<Point>;
        private var speedFactor: Number;
        private var currentPathIndex: int;
        private var currentPosition: Point;
        private var pathOffset: Point;

        public function Enemy(image: Image, path: Vector.<Point>, pathOffset: Point, speedFactor: Number) {
            this.image = image;
            this.path = path;
            this.pathOffset = pathOffset;
            this.speedFactor = speedFactor;
            this.currentPathIndex = 1;
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:* = null): void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            setPosition(this.path[0]);
            addChild(this.image);
        }

        public function advanceTime(time:Number): void {
            this.checkIfNewPathIndex();
            var movingDirection: Point = this.getMovingDirection();
            movingDirection.normalize(0.9 * this.speedFactor);
            this.moveBy(movingDirection);
        }

        public function start(): void {
            Starling.juggler.add(this);
        }

        private function checkIfNewPathIndex(): void {
            if (this.path.length - 1 == this.currentPathIndex) {
                return;
            }

            var distance: Number = Math.abs(Point.distance(this.currentPosition, this.path[this.currentPathIndex]));
            if (distance < NEW_PATH_POINT_LAMBDA) {
                this.currentPathIndex++;
            }
        }

        private function getMovingDirection(): Point {
            return this.path[this.currentPathIndex].subtract(this.currentPosition);
        }

        private function setPosition(position: Point): void {
            this.currentPosition = position;
            this.x = position.x + this.pathOffset.x - this.width / 2;
            this.y = position.y + this.pathOffset.y - this.height / 2;
        }

        private function moveBy(vector: Point): void {
            // TODO: refactor these two functions (this and the above one)
            this.currentPosition.x += vector.x;
            this.currentPosition.y += vector.y;

            this.x = this.currentPosition.x + this.pathOffset.x - this.width / 2;
            this.y = this.currentPosition.y + this.pathOffset.y - this.height / 2;
        }

    }

}
