package td.music {

    import flash.media.Sound;
    import flash.net.URLRequest;

    import td.Context;
    import td.constants.Music;
    import td.utils.MathUtils;

    public class MusicManager {

        private const mainMenuMusic: Array.<Sound> = [createSound(Music.HEROIC_DEMISE)];

        private const levelIntroMusic: Sound = createSound(Music.BATTLE_THEME_A);
        private var levelMusic: Array.<Sound> = [createSound(Music.THE_DARK_AMULET), createSound(Music.DARK_DESCENT),
            createSound(Music.EPIC_BOSS_BATTLE), createSound(Music.HEROES_THEME), createSound(Music.IRELANDS_COAST)
        ];

        private const musicQueue: MusicQueue = new MusicQueue();

        public function MusicManager() {
            Context.musicManager = this;
        }

        public function playMainMenuMusicIfNotPlaying(): void {
            if (!this.mainMenuMusic == this.musicQueue.getPlaylist()) {
                this.musicQueue.changePlaylist(this.mainMenuMusic);
                this.musicQueue.startOver();
            }
        }

        public function playLevelMusic(): void {
            this.levelMusic = MathUtils.shuffleInPlace(this.levelMusic);

            var levelPlaylist: Array.<Sound> = [levelIntroMusic].concat(this.levelMusic);

            this.musicQueue.changePlaylist(levelPlaylist);
            this.musicQueue.startOver();
        }

        private static function createSound(path: String): Sound{
            return new Sound(new URLRequest(path));
        }

    }

}
