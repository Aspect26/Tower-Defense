package td.buildings {

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    import td.Context;

    public class Tower extends Sprite {

        private var image: Image;
        private var imagePath: String;

        private var damage: int;
        private var cooldawn: Number;

        public function Tower(imagePath: String, damage: int, cooldawn: int) {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            this.imagePath = imagePath;
            this.damage = damage;
            this.cooldawn = cooldawn;
        }

        public function onAddedToStage() : void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            image = Context.newImage(this.imagePath);
            addChild(this.image);

        }

    }

}
