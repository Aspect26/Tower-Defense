package td.music {
    import flash.media.Sound;
    import flash.net.URLRequest;

    import td.Context;
    import td.constants.Music;

    public class SoundManager {

        public static var COIN_DROP: Sound;
        public static var COIN_PICK: Sound;
        public static var DEATH_BLOOD_KNIGHT: Sound;
        public static var DEATH_GLAQ: Sound;
        public static var DEATH_SPAWN: Sound;
        public static var DEATH_MAGE: Sound;
        public static var BUTTON_CLICK: Sound;
        public static var SHOT_1: Sound;
        public static var SHOT_2: Sound;
        public static var SHOT_3: Sound;
        public static var SHOT_4: Sound;
        public static var VICTORY: Sound;

        public function SoundManager() {
            Context.soundManager = this;
        }

        public function initialize(): void {
            COIN_DROP = createSound(Music.SOUND_COIN_DROP);
            COIN_PICK = createSound(Music.SOUND_COIN_PICK);
            DEATH_BLOOD_KNIGHT = createSound(Music.SOUND_DEATH_BLOOD_KNIGHT);
            DEATH_GLAQ = createSound(Music.SOUND_DEATH_GLAQ);
            DEATH_SPAWN = createSound(Music.SOUND_DEATH_SPAWN);
            DEATH_MAGE = createSound(Music.SOUND_DEATH_MAGE);
            BUTTON_CLICK = createSound(Music.SOUND_BUTTON_CLICK);
            SHOT_1 = createSound(Music.SOUND_SHOT_1);
            SHOT_2 = createSound(Music.SOUND_SHOT_2);
            SHOT_3 = createSound(Music.SOUND_SHOT_3);
            SHOT_4 = createSound(Music.SOUND_SHOT_4);
            VICTORY = createSound(Music.SOUND_VICTORY);
        }

        public function playSound(sound: Sound): void {
            sound.play();
        }

        private static function createSound(path: String): Sound {
            trace(path);
            return new Sound(new URLRequest(path));
        }
    }

}
