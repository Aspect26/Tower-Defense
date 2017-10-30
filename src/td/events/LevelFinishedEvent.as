package td.events {

    import starling.events.Event;

    public class LevelFinishedEvent extends Event {

        public static const TYPE: String = "levelFinished";

        public function LevelFinishedEvent(bubbles: Boolean, data: int) {
            super(TYPE, bubbles, data);
        }

    }

}
