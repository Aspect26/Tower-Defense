package td.map {
    import flash.geom.Point;
    import flash.utils.Dictionary;

    import io.arkeus.tiled.TiledMap;

    import starling.display.DisplayObject;

    import td.Context;

    import td.buildings.Tower;

    import td.constants.Colors;
    import td.utils.Position;
    import td.utils.Size;

    import td.utils.draw.Primitive;

    public class Map {

        public static const TILE_SIZE: int = 20;
        private static const WIDTH: int = 40;
        private static const HEIGHT: int = 25;
        private var occupiedTiles: Array;
        private var occupiedTilesOverlay: Primitive;
        private var towerOccupationTiles: Object;

        private var mapData: TiledMap;
        private var map: Class;

        public function Map(map: Class) {
            this.map = map;
            this.initialize();
        }

        private function initialize(): void {
            mapData = Context.mapLoader.loadMap(this);

            occupiedTiles = [];
            for (var x: int = 0 ; x < WIDTH; ++x) {
                occupiedTiles.push([]);
                for (var y: int = 0; y < HEIGHT; ++y) {
                    occupiedTiles[x].push(false);
                }
            }

            this.occupiedTilesOverlay = new Primitive();
            towerOccupationTiles = {};
        }

        public function isTileOccupied(x: int, y: int): Boolean {
            if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) {
                return true;
            }
            return this.occupiedTiles[x][y];
        }

        public function getMapXMLClass() : Class {
            return map;
        }

        public function getMapData(): TiledMap {
            return this.mapData;
        }

        public function getOccupationOverlay(): Primitive {
            return this.occupiedTilesOverlay;
        }

        public function setRectangleOccupied(x: int, y: int, width: int, height: int): DisplayObject {
            for (var i: int = x; i < width + x; ++i) {
                for (var j: int = y; j < height + y; ++j) {
                    this.occupiedTiles[i][j] = true;
                }
            }
            return this.occupiedTilesOverlay.addChild(this.occupiedTilesOverlay.rectangle(x * TILE_SIZE, y * TILE_SIZE, (x+width) * TILE_SIZE,
                    (y + height) * TILE_SIZE, Colors.OCCUPATION_OVERLAY, 0, 0, 0.2));
        }

        public function unoccupyTowerTiles(tower: Tower): void {
            var x: int = tower.getPosition().x / TILE_SIZE;
            var y: int = tower.getPosition().y / TILE_SIZE;

            var size: Size = tower.getSize();

            for (var i: int = x; i < x + size.width; ++i) {
                for (var j: int = y; j < y + size.height; ++j) {
                    this.occupiedTiles[i][j] = false;
                }
            }

            this.occupiedTilesOverlay.removeChild(this.towerOccupationTiles[tower]);
        }

        public function addTower(tower: Tower, position: Point): Boolean {
            if (isRectangleEmpty(position, tower.getSize())) {
                var towerOccupationOverlay: DisplayObject = this.setRectangleOccupied(position.x, position.y, tower.getSize().width, tower.getSize().height)
                this.towerOccupationTiles[tower] = towerOccupationOverlay;
                return true;
            } else {
                return false;
            }
        }

        public function removeTower(tower: Tower): void {
            this.unoccupyTowerTiles(tower);
        }

        private function isRectangleEmpty(position: Point, size: Size): Boolean {
            for (var i:int = position.x; i < size.width + position.x; ++i) {
                for (var j:int = position.y; j < size.height + position.y; ++j) {
                    if (this.isTileOccupied(i, j)) {
                        return false;
                    }
                }
            }
            return true;
        }

    }

}
