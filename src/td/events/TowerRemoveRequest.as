package td.events {
    import starling.events.Event;

    import td.buildings.Tower;

    public class TowerRemoveRequest extends Event {

        public static const TYPE: String = "towerRemoveRequest";

        public var tower: Tower;

        public function TowerRemoveRequest(tower: Tower) {
            super(TYPE, true, null);
            this.tower = tower;
        }

        public function getTower(): Tower {
            return this.tower;
        }

    }
}
