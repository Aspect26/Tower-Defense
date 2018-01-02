package td.enemies {
    import flash.geom.Point;
    import flash.media.Sound;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import td.Context;

    import td.events.EnemyDiedEvent;
    import td.events.EnemyReachedEndEvent;
    import td.utils.Utils;

    public class Enemy extends Sprite implements IAnimatable {

        private static const NEW_PATH_POINT_LAMBDA: Number = 3;

        private var image: Image;
        private var deathSound: Sound;
        private var path: Vector.<Point>;
        private var speedFactor: Number;
        private var currentPathIndex: int;
        private var currentPosition: Point;
        private var pathOffset: Point;
        private var timeOffset: Number;
        private var life: int;
        private var moneyReward: int;
        private var alive: Boolean;
        private var movingDirection: Point;

        public function Enemy(image: Image, deathSound: Sound, life: int, moneyReward: int, path: Vector.<Point>,
                              pathOffset: Point, timeOffset: Number, speedFactor: Number, boost: Number) {
            this.image = image;
            this.deathSound = deathSound;
            this.life = life * boost;
            this.moneyReward = moneyReward;
            this.path = path;
            this.pathOffset = pathOffset;
            this.speedFactor = speedFactor * (1.0 + ((boost - 1.0) / 2));
            this.timeOffset = timeOffset;
            this.alive = false;
            this.currentPathIndex = 1;
            this.movingDirection = new Point();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:* = null): void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            setPosition(new Point(this.path[0].x, this.path[0].y));
            Starling.juggler.add(this);
        }

        public function getDistanceFrom(x: int, y: int): int {
            var myY: int = this.y + this.width / 2;
            var myX: int = this.x + this.height / 2;
            return Math.sqrt(Math.pow(myY - y, 2) + Math.pow(myX - x, 2));
        }

        public function getX(): int {
            return this.x + this.width / 2;
        }

        public function getY(): int {
            return this.y + this.height / 2;
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
                this.computeMovingDirection(delta);
                this.move();
            }
        }

        public function hit(damage: int): void {
            if (this.life <= 0) {
                return;
            }
            this.life -= damage;
            if (this.life <= 0) {
                this.alive = false;
                Context.soundManager.playSound(this.deathSound);
                dispatchEvent(new EnemyDiedEvent(true, this));
            }
        }

        private function checkIfNewPathIndex(): void {
            var distance: Number = Utils.getDistance(this.currentPosition.x, this.currentPosition.y,
                    this.path[this.currentPathIndex].x, this.path[this.currentPathIndex].y);
            if (distance < NEW_PATH_POINT_LAMBDA) {
                if (this.path.length - 1 == this.currentPathIndex) {
                    Starling.juggler.remove(this);
                    this.removeChild(image);
                    dispatchEvent(new EnemyReachedEndEvent(this));
                } else {
                    this.currentPathIndex++;
                }
            }
        }

        private function computeMovingDirection(timeDelta: Number): void {
            this.movingDirection.x = this.path[this.currentPathIndex].x - this.currentPosition.x;
            this.movingDirection.y = this.path[this.currentPathIndex].y - this.currentPosition.y;

            this.movingDirection.normalize(12.0 * timeDelta * this.speedFactor);
        }

        private function setPosition(position: Point): void {
            this.currentPosition = position;
            this.x = position.x + this.pathOffset.x - this.width / 2;
            this.y = position.y + this.pathOffset.y - this.height / 2;
        }

        private function move(): void {
            this.currentPosition.x += this.movingDirection.x;
            this.currentPosition.y += this.movingDirection.y;
            this.setPosition(this.currentPosition);
        }

    }

}
