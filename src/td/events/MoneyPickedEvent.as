package td.events {
    import starling.events.Event;

    import td.dropable.CoinSprite;

    public class MoneyPickedEvent extends Event {

        public static const TYPE: String = "moneyPicked";

        public var moneySprite: CoinSprite;

        public function MoneyPickedEvent(moneySprite: CoinSprite, data: int, bubbles: Boolean) {
            super(TYPE, bubbles, data);
            this.moneySprite = moneySprite;
        }

    }
}
