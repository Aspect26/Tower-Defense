package td.enemies {

    import starling.display.Sprite;
    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.events.Event;

    import td.Context;

    public class GreenTank extends Sprite implements IAnimatable {

        private var tankBody:Image;
        private var tankGun:Image;

        public function GreenTank() {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(e:* = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            tankBody = Context.newImage('towerDefense_tile268.png');
            addChild(tankBody);

            tankGun = Context.newImage('towerDefense_tile291.png');
            tankGun.x = tankBody.width / 2 - tankGun.width / 2 - 5;
            tankGun.y = tankBody.height / 2 - tankGun.height / 2;

            addChild(tankGun);

            Starling.juggler.add(this);
        }

        public function advanceTime(time:Number):void {
            this.x += time * 20;
        }

    }
}