package td.map {
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

        public function Map() {
            this.initialize();
        }

        private function initialize(): void {
            occupiedTiles = [];
            for (var x: int = 0 ; x < WIDTH; ++x) {
                occupiedTiles.push([]);
                for (var y: int = 0; y < HEIGHT; ++y) {
                    occupiedTiles[x].push(false);
                }
            }

            this.occupiedTilesOverlay = new Primitive();
        }

        public function isTileOccupied(x: int, y: int): Boolean {
            if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) {
                return true;
            }
            return this.occupiedTiles[x][y];
        }

        public function getOccupationOverlay(): Primitive {
            return this.occupiedTilesOverlay;
        }

        public function setRectangleOccupied(x: int, y: int, width: int, height: int): void {
            for (var i: int = x; i < width + x; ++i) {
                for (var j: int = y; j < height + y; ++j) {
                    this.occupiedTiles[i][j] = true;
                }
            }
            this.occupiedTilesOverlay.addChild(this.occupiedTilesOverlay.rectangle(x * TILE_SIZE, y * TILE_SIZE, (x+width) * TILE_SIZE,
                    (y + height) * TILE_SIZE, Colors.OCCUPATION_OVERLAY, 0, 0, 0.2));
        }

        public function addTower(tower: Tower, position: Position): Boolean {
            if (isRectangleEmpty(position, tower.getSize())) {
                this.setRectangleOccupied(position.x, position.y, tower.getSize().width, tower.getSize().height);
                return true;
            } else {
                return false;
            }
        }

        private function isRectangleEmpty(position: Position, size: Size): Boolean {
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
