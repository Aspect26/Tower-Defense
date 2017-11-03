package td.dropable {

    import starling.events.Event;
    import starling.events.TouchEvent;

    import td.Context;

    import td.constants.Game;
    import td.constants.Images;

    import td.events.MoneyPickedEvent;
    import td.music.SoundManager;
    import td.utils.MathUtils;

    import td.utils.draw.Primitive;

    public class MoneySprite extends Primitive {

        public function MoneySprite(x: int, y: int) {
            this.x = x;
            this.y = y;
            this.setTouchable(true);
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event: Event): void {
            this.addChild(Context.newImage(Images.COIN));
            Context.soundManager.playSound(SoundManager.COIN_DROP);
        }

        public override function onClick(event: TouchEvent) : void {
            dispatchEvent(new MoneyPickedEvent(this, MathUtils.randomInt(Game.MONEY_DROP_MIN, Game.MONEY_DROP_MAX), true));
            Context.soundManager.playSound(SoundManager.COIN_PICK);
        }

    }

}
