package gallery.view.utils.bowcamp {

    /** Class accepts bowcamp code string, and parses them according to bowcamp algorithm taking into account needs of this application.
     * This class is used only by Collage view and has supplementary role in displaying objects.
     * Current implementation supports Square tiles, that can form square or rectangle.*/
    public class BowcampOrderObject {
        public var numItems:uint;

        public var minTileSize:Number;

        public var width:Number;
        public var height:Number;

        public var elemArray:Array = new Array();

        private var _currentIndex:uint;

        public function BowcampOrderObject(bkpString:String, tileSize:Number) {
            parseBkpString(bkpString, tileSize);
            _currentIndex = 0;
        }

        private function parseBkpString(string:String, tileSize:Number):void {
            var parsedString:Array = string.split(" ");
            minTileSize = tileSize;
            numItems = parsedString[0];
            width = parsedString[1] * minTileSize;
            height = parsedString[2] * minTileSize;

            var tile:BowcampSquareTileObject;


            var i:uint, k:uint, l:uint;
            var squareSize:Number = parsedString[1];
            var order:Vector.<uint> = new Vector.<uint>(numItems > squareSize ? numItems : squareSize);

            for(i = 3; i < parsedString.length; i++) {

                k = 0;

                for(l = 1; l < squareSize; l++) {
                    if(order[l] < order[k]) {
                        k = l;
                    }
                }

                tile = new BowcampSquareTileObject();
                tile.tileX = k * minTileSize;
                tile.tileY = order[k] * minTileSize;
                tile.tileSize = Number(parsedString[i]) * minTileSize;
                elemArray.push(tile);

                for(l = 0; l < parsedString[i]; l++) {
                    order[k + l] += Number(parsedString[i]);
                }
            }
        }

        public function nextTileObject():BowcampSquareTileObject {
            return elemArray[currentIndex++];
        }

        public function hasNextTileObject():Boolean {
            return currentIndex < elemArray.length;
        }


        public function get currentIndex():uint {
            return _currentIndex;
        }

        public function set currentIndex(value:uint):void {
            _currentIndex = value;
        }
    }
}
