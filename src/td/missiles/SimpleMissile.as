package td.missiles {

    import flash.geom.Point;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import td.buildings.Tower;
    import td.enemies.Enemy;
    import td.events.MissileHitTargetEvent;
    import td.utils.VectorUtils;

    public class SimpleMissile extends Sprite implements IAnimatable {

        private static var speed: Number = 40.0;
        private static var hitDistance: Number = 10.0;

        private var source: Tower;
        private var target: Enemy;
        private var currentPosition: Point;
        private var image: Image;
        private var active: Boolean;
        private var movingDirection: Point;

        public function SimpleMissile() {
            this.currentPosition = new Point();
            this.movingDirection = new Point();
        }

        public function reinitialize(x: int, y: int, source: Tower, target: Enemy): void {
            this.source = source;
            this.target = target;
            this.image = source.getMissileImage();
            this.active = false;

            this.movingDirection.x = 0;
            this.movingDirection.y = 0;

            this.currentPosition.x = x;
            this.currentPosition.y = y;

            this.x = currentPosition.x;
            this.y = currentPosition.y;

            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage)
        }

        private function onAddedToStage(event: Event): void {
            this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            this.addChild(this.image);
            this.active = true;
            Starling.juggler.add(this);
        }

        private function onRemovedFromStage(event: Event): void {
            this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            this.active = false;
        }

        public function getCurrentPosition(): Point {
            return this.currentPosition;
        }

        public function advanceTime(time: Number): void {
            if (!this.active) {
                return;
            }

            VectorUtils.getNormalizedDirection(this.movingDirection, currentPosition.x, currentPosition.y, target.getX(), target.getY(), time * speed);
            this.move();
            this.rotation = Math.atan2(movingDirection.y, movingDirection.x);
            if (target.getDistanceFromPosition(this.currentPosition) < hitDistance) {
                dispatchEvent(new MissileHitTargetEvent(true, this));
            }
        }

        public function hitTarget(): void {
            this.target.hit(this.source.getDamage());
        }

        private function move(): void {
            this.currentPosition.x += this.movingDirection.x;
            this.currentPosition.y += this.movingDirection.y;

            this.x += movingDirection.x;
            this.y += movingDirection.y;
        }
    }

}
