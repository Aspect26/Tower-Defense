package td.missiles {
    import starling.events.Event;

    public class MissileHitTargetEvent extends Event {

        public static const MISSILE_HIT_TARGET: String = "missileHitTarget";

        public function MissileHitTargetEvent(bubbles: Boolean, data: SimpleMissile) {
            super(MISSILE_HIT_TARGET, bubbles, data);
        }

    }

}
