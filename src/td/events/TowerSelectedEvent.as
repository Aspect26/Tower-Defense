package td.events {
    import starling.events.Event;

    import td.buildings.Tower;

    public class TowerSelectedEvent extends Event {

        public static const TYPE: String = "towerSelected";

        public var tower: Tower;

        public function TowerSelectedEvent(tower: Tower) {
            super(TYPE, true, null);
            this.tower = tower;
        }

        public function getTower(): Tower {
            return this.tower;
        }

    }
}
