package io.arkeus.tiled {
	/**
	 * Represents an image within a tiled map. The source is a string containing the path
	 * to the image relative to the location of the map.
	 */
	public class TiledImage {
		/** The string containing the path to the image relative to the map file. */
		public var source:String;
		/** The string containing only the image file name (w/o the path leading to it). */
		public var sourceFilename:String;
		/** The width of the image. */
		public var width:uint;
		/** The height of the image. */
		public var height:uint;
		/** The transparent color, -1 if no transparent color. */
		public var transparentColor:int;
		
		/**
		 * @param tmx The XMLList containing the <image> object.
		 */
		public function TiledImage(tmx:XMLList) {
			source = tmx.@source;
			sourceFilename = (source == null || source.length == 0 ? "" : source.substring(source.lastIndexOf("/") + 1));
			width = tmx.@width;
			height = tmx.@height;
			transparentColor = "@trans" in tmx ? TiledUtils.colorStringToUint(tmx.@trans) : -1;
		}
		
	}
}
