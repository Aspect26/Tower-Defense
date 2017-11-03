package td.map
{
    import io.arkeus.tiled.TiledMap;
    import io.arkeus.tiled.TiledReader;
    import td.Context;

    public class MapLoader
    {
        [Embed(source="../../assets/levels/stage1/tileset.tsx", mimeType="application/octet-stream")]
        protected const stageOneTileset: Class;
        [Embed(source="../../assets/levels/stage1/props.tsx", mimeType="application/octet-stream")]
        protected const stageOneProps: Class;

        protected const reader: TiledReader = new TiledReader();

        public function MapLoader()
        {
            // we initialize reader to be ready to serve...
            reader.loadTileSetFromEmbedded("tileset.tsx", stageOneTileset);
            reader.loadTileSetFromEmbedded("props.tsx", stageOneProps)

            // subscribe itself
            Context.mapLoader = this;
        }

        public function loadMap(map: Map) : TiledMap {
            return reader.loadMapFromEmbedded(map.getMapXMLClass());
        }

    }

}