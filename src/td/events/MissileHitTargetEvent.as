package td.events {
    import td.missiles.*;
    import starling.events.Event;

    public class MissileHitTargetEvent extends Event {

        public static const TYPE: String = "missileHitTarget";

        public function MissileHitTargetEvent(bubbles: Boolean, data: SimpleMissile) {
            super(TYPE, bubbles, data);
        }

    }

}
