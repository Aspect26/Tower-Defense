package td.missiles {

    import flash.geom.Point;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import td.buildings.Tower;
    import td.enemies.Enemy;
    import td.utils.VectorUtils;

    public class SimpleMissile extends Sprite implements IAnimatable {

        private static var speed: Number = 100.0;
        private static var hitDistance: Number = 15.0;

        private var source: Tower;
        private var target: Enemy;
        private var currentPosition: Point;
        private var image: Image;

        public function SimpleMissile(position: Point, source: Tower, target: Enemy, image: Image) {
            this.source = source;
            this.target = target;
            this.currentPosition = position;
            this.image = image;

            this.x = currentPosition.x;
            this.y = currentPosition.y;

            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event: Event): void {
            this.addChild(this.image);
            Starling.juggler.add(this);
        }

        public function advanceTime(time: Number): void {
            var movingDirection: Point = VectorUtils.getNormalizedDirection(currentPosition, target.getPosition(), time * speed);
            this.moveBy(movingDirection);
            this.rotation = Math.atan2(movingDirection.y, movingDirection.x);
            if (target.getDistanceFrom(this.currentPosition) < hitDistance) {
                dispatchEvent(new MissileHitTargetEvent(true, this));
            }
        }

        private function moveBy(directionVector: Point): void {
            this.currentPosition.x += directionVector.x;
            this.currentPosition.y += directionVector.y;

            this.x += directionVector.x;
            this.y += directionVector.y;
        }
    }

}