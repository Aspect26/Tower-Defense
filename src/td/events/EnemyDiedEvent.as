package td.events {
    import td.enemies.*;
    import starling.events.Event;

    public class EnemyDiedEvent extends Event {

        public static const TYPE: String = "enemyDied";

        public function EnemyDiedEvent(bubbles: Boolean, data: Enemy) {
            super(TYPE, bubbles, data);
        }

    }

}
