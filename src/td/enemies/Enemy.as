package td.enemies {
    import flash.geom.Point;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import td.events.EnemyDiedEvent;

    public class Enemy extends Sprite implements IAnimatable {

        private static const NEW_PATH_POINT_LAMBDA: Number = 3;

        public var onReachedEnd: Function;

        private var image: Image;
        private var path: Vector.<Point>;
        private var speedFactor: Number;
        private var currentPathIndex: int;
        private var currentPosition: Point;
        private var pathOffset: Point;
        private var timeOffset: Number;
        private var life: int;
        private var moneyReward: int;
        private var alive: Boolean;

        public function Enemy(image: Image, life: int, moneyReward: int, path: Vector.<Point>, pathOffset: Point, timeOffset: Number, speedFactor: Number) {
            this.image = image;
            this.life = life;
            this.moneyReward = moneyReward;
            this.path = path;
            this.pathOffset = pathOffset;
            this.speedFactor = speedFactor;
            this.timeOffset = timeOffset;
            this.alive = false;
            this.currentPathIndex = 1;
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:* = null): void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            setPosition(new Point(this.path[0].x, this.path[0].y));
            Starling.juggler.add(this);
        }

        public function getDistanceFrom(position: Point): int {
            var y: int = this.y + this.width / 2;
            var x: int = this.x + this.height / 2;
            return Math.sqrt(Math.pow(y - position.y, 2) + Math.pow(x - position.x, 2));
        }

        public function getPosition(): Point {
            return new Point(this.x + this.width / 2, this.y + this.height / 2);
        }

        public function getMoneyReward(): int {
            return this.moneyReward;
        }

        public function isAlive(): Boolean {
            return this.alive;
        }

        public function advanceTime(delta: Number): void {
            if (this.timeOffset > 0) {
                this.timeOffset -= delta;
                if (this.timeOffset <= 0) {
                    this.addChild(this.image);
                    this.alive = true;
                }
            } else {
                this.checkIfNewPathIndex();
                this.moveBy(this.getMovingDirection(delta));
            }
        }

        public function hit(damage: int): void {
            if (this.life <= 0) {
                return;
            }
            this.life -= damage;
            if (this.life <= 0) {
                this.alive = false;
                dispatchEvent(new EnemyDiedEvent(true, this));
            }
        }

        private function checkIfNewPathIndex(): void {
            var distance: Number = Math.abs(Point.distance(this.currentPosition, this.path[this.currentPathIndex]));
            if (distance < NEW_PATH_POINT_LAMBDA) {
                if (this.path.length - 1 == this.currentPathIndex) {
                    Starling.juggler.remove(this);
                    this.removeChild(image);
                    if (onReachedEnd) {
                        onReachedEnd(this);
                    }
                } else {
                    this.currentPathIndex++;
                }
            }
        }

        private function getMovingDirection(timeDelta: Number): Point {
            var movingDirection: Point = this.path[this.currentPathIndex].subtract(this.currentPosition);
            movingDirection.normalize(30.0 * timeDelta * this.speedFactor);
            return movingDirection;
        }

        private function setPosition(position: Point): void {
            this.currentPosition = position;
            this.x = position.x + this.pathOffset.x - this.width / 2;
            this.y = position.y + this.pathOffset.y - this.height / 2;
        }

        private function moveBy(vector: Point): void {
            this.currentPosition.x += vector.x;
            this.currentPosition.y += vector.y;
            this.setPosition(this.currentPosition);
        }

    }

}
