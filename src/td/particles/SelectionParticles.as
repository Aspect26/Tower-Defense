package td.particles
{
    import starling.display.Sprite;
    import starling.extensions.PDParticleSystem;
    import starling.textures.Texture;
    import starling.core.Starling;

    public class SelectionParticles extends Sprite
    {

        [Embed(source="../../assets/particles/selection.pex", mimeType="application/octet-stream")]
        private static const FireConfig:Class;

        // embed particle texture
        [Embed(source = "../../assets/particles/selection.png")]
        private static const ParticleTexture:Class;

        // instantiate embedded objects
        private static var psConfig:XML = XML(new FireConfig());
        private static  var psTexture:Texture = Texture.fromBitmap(new ParticleTexture());

        private var ps:PDParticleSystem;

        private var started: Boolean = false;

        public function SelectionParticles(x: int = 0, y: int = 0, scale: Number = 1.0) {
            // create particle system
            ps = new PDParticleSystem(psConfig, psTexture);
            ps.x = 0;
            ps.y = 0;

            // change position where particles are emitted
            ps.emitterX = 0;
            ps.emitterY = 0;

            this.x = x;
            this.y = y;
            this.scale = scale;
        }

        public function start() : void {
            if (started) return;
            started = true;

            // add it to the stage (juggler will be managed automatically)
            addChild(ps);
            Starling.juggler.add(ps);
            // start emitting particles

            ps.start();
            ps.advanceTime(5);
        }

        public function stop() : void {
            if (!started) return;
            started = false;
            try {
                removeChild(ps);
            } catch (e: Error) {
            }
            try {
                Starling.juggler.remove(ps);
            } catch (e:Error) {
            }
        }

        public function kill() : void {
            if (ps == null) return;
            stop();
            ps = null;
            psTexture = null;
            psConfig = null;
        }

    }

}