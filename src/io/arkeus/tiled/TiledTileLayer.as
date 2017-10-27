package io.arkeus.tiled {
	/**
	 * Represents a single tile layer within a map.
	 */
	public class TiledTileLayer extends TiledLayer {
		/** The encoding used on the layer data. */
		public var encoding:String;
		/** The compression used on the layer data. */
		public var compression:String;
		/** The parsed layer data, uncompressed and unencoded. 
		 * [column ~ x][row ~ y] -- multi-valued, either 1) null - no tile
		 *                                               2) int - unresolved GID
		 *                                               3) TiledTile - as read from TiledTileset if present within the TiledMap context; use {@link #resolveTiles(TiledMap)} to bind)
		 **/
		public var data:Array;

		public function TiledTileLayer(tmx:XML) {
			super(tmx);
			
			var dataNode:XML = tmx.data[0];
			encoding = "@encoding" in dataNode ? dataNode.@encoding : null;
			compression = "@compression" in dataNode ? dataNode.@compression : null;
			
			if (dataNode.tile.length() > 0) {
				// XML definition!
				loadDataXML(dataNode);
			} else {
				// TODO: check for and handle 1.0.3 CSV format here!
				
			    // Tiled 0.9.0 definition
				data = TiledUtils.stringToTileData(dataNode.text(), width, encoding, compression);
			}
		}
		
		protected function loadDataXML(dataNode: XML) : void {
			data = [];
			
			var tileNum: int;
			for (var y: int = 0; y < height; ++y) {
				for (var x: int = 0; x < width; ++x) {	
					while (x >= data.length) {
						data[data.length] = [];
					}
					if (dataNode.tile[tileNum]) {
						var tile: XML = dataNode.tile[tileNum];
						var gid: int = tile.@gid;
						data[x][y] = gid;
					} else {
						data[x][y] = null;
					}
					++tileNum;
				}
			}
		}
		
		public function resolveTiles(map: TiledMap) : void {
			if (data == null) {
				trace("TiledTileLayer.resolveTiles(): data is null, cannot resolve!");
				return;
			}
			for (var y: int = 0; y < height; ++y) {
				for (var x: int = 0; x < width; ++x) {				
					if (data[x][y] is int) {
						var gid: int = data[x][y];
						if (gid == 0) {
							data[x][y] = null;
						} else {
							var tile: TiledTile = getTile(gid, map);
							if (tile != null) {
								data[x][y] = tile;
							}
						}
					}					
				}
			}
		}
			
		protected function getTile(gid: int, map: TiledMap) : TiledTile {
			if (gid <= 0) return null;
			
			var lastTS: TiledTileset = null;
			
			for each (var ts: TiledTileset in map.tilesets.tilesetsVector) {
				if (gid < ts.firstGid) {
					break;
				}				
				lastTS = ts;
			}
			
			var id: int = gid - lastTS.firstGid;					
			var realTS: TiledTileset;
			if (lastTS.name != null && lastTS.name.length > 0) {
				realTS = map.ctx.tilesets[lastTS.name];
			}
			if (realTS == null && lastTS.source != null) {
				realTS = map.ctx.tilesets[lastTS.source];
			}				
			if (realTS != null) {					
				var tile: TiledTile = realTS.tiles[id];
				return tile;
			}
			
			return null;
		}
			
	}
		
}
