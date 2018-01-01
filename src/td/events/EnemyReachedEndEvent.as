package td.events {
    import td.enemies.*;
    import starling.events.Event;

    public class EnemyReachedEndEvent extends Event {

        public static const TYPE: String = "enemyReachedEnd";

        public function EnemyReachedEndEvent(data: Enemy) {
            super(TYPE, true, data);
        }

    }

}
