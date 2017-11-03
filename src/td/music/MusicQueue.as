package td.music {
    import flash.media.SoundChannel;

    import starling.core.Starling;

    public class MusicQueue {

        private var playlist: Array;
        private var currentSound: SoundChannel;
        private var currentTrack: int = 0;

        public function MusicQueue() {
            this.playlist = [];
        }

        public function changePlaylist(playlist: Array): void {
            this.playlist = playlist;
        }

        public function getPlaylist(): Array {
            return this.playlist;
        }

        public function startOver(): void {
            currentTrack = -1;
            Starling.juggler.removeDelayedCalls(playNextSong);
            this.playNextSong();
        }

        public function stop(): void {
            this.currentSound.stop();
            Starling.juggler.removeDelayedCalls(playNextSong);
        }

        private function playNextSong(): void {
            if (currentSound) {
                currentSound.stop();
            }

            currentTrack++;
            if (currentTrack >= this.playlist.length) {
                currentTrack = 0;
            }

            currentSound = this.playlist[currentTrack].play();
            Starling.juggler.delayCall(playNextSong, this.playlist[currentTrack].length / 1000 + 1);
        }
    }

}
