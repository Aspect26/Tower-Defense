package td.events {
    import starling.events.Event;

    import td.dropable.MoneySprite;

    public class MoneyPickedEvent extends Event {

        public static const TYPE: String = "moneyPicked";

        public var moneySprite: MoneySprite;

        public function MoneyPickedEvent(moneySprite: MoneySprite, data: int, bubbles: Boolean) {
            super(TYPE, bubbles, data);
            this.moneySprite = moneySprite;
        }

    }
}
