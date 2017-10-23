package io.arkeus.tiled {
	import flash.utils.Dictionary;
	import td.utils.Utils;
	/**
	 * Reader for loading Tiled 1.0.3 maps.
	 */
	public class TiledReader {
			
		/** tileset name -- TiledTileset */
		public var tilesets: Dictionary = new Dictionary();
		
		/**
		 * Creates a new TiledReader.
		 */
		public function TiledReader() {
		}
		
		/**
		 * Reads an embedded xml file and loads a TiledMap from it.
		 * 
		 * @param map The embedded(application/octet-stream) class containing the tmx file.
		 * @return The fully parsed TiledMap.
		 */
		public function loadMapFromEmbedded(map:Class):TiledMap {
			return loadMapFromXML(Utils.xmlFromByteArrayClass(map));
		}
		
		/**
		 * Reads an XML object and loads a TiledMap from it.
		 * 
		 * @param map The XML object in default tmx file format.
		 * @return The fully parsed TiledMap.
		 */
		public function loadMapFromXML(map:XML):TiledMap {
			return new TiledMap(map, this);
		}
		
		/**
		 * Reads an embedded xml file and loads a TiledMap from it.
		 * 
		 * @param name id of tilesets as used by map TMX files
		 * @param map The embedded (application/octet-stream) class containing the tmx file.
		 * @return The fully parsed TiledMap.
		 */
		public function loadTileSetFromEmbedded(name: String, tileSet:Class):TiledTileset {
			return loadTileSetFromXML(name, Utils.xmlFromByteArrayClass(tileSet));
		}
		
		/**
		 * Reads an XML object and loads a TiledMap from it.
		 * 
		 * @param name id of tilesets as used by map TMX files
		 * @param map The XML object in default tmx file format.
		 * @return The fully parsed TiledMap.
		 */
		public function loadTileSetFromXML(name: String, tileSet:XML):TiledTileset {
			var ts: TiledTileset = new TiledTileset(tileSet);
			tilesets[name] = ts;
			tilesets[ts.name] = ts;			
			return ts;
		}
	}
}
