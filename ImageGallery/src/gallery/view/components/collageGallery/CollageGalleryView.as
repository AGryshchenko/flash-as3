package gallery.view.components.collageGallery {
    import flash.display.Sprite;

    import gallery.model.vo.IGalleryImage;
    import gallery.view.components.IGalleryView;
    import gallery.view.utils.bowcamp.BowcampOrderObject;
    import gallery.view.utils.bowcamp.BowcampSquareTileObject;

    import org.osflash.signals.Signal;

    public class CollageGalleryView extends Sprite implements IGalleryView {

        private static const MIN_TILE_SIZE:uint = 50;


        private var _dataProvider:Array;

        private var _imageSelected:Signal = new Signal(Number);

        private var _bkpOrder:String;

        private var _tiles:Vector.<CollageTileView> = new Vector.<CollageTileView>();


        public function CollageGalleryView(bkpOrder:String) {
            this._bkpOrder = bkpOrder;
        }

        private function galleryUpdated():void {
            unloadAllTiles();

            var bkpObject:BowcampOrderObject = new BowcampOrderObject(_bkpOrder, MIN_TILE_SIZE);

            var currentTileObject:BowcampSquareTileObject;
            var tile:CollageTileView;
            var galleryImageIndex:uint = 0;

            while(bkpObject.hasNextTileObject()) {
                currentTileObject = bkpObject.nextTileObject();
                tile = new CollageTileView();
                tile.x = currentTileObject.tileX;
                tile.y = currentTileObject.tileY;
                tile.width = tile.height = currentTileObject.tileSize;
                if(galleryImageIndex >= dataProvider.length) {
                    galleryImageIndex = 0;
                }
                tile.galleryImage = dataProvider[galleryImageIndex++];
                _tiles.push(tile);
                this.addChild(tile);
            }
            _tiles[0].imageDisplayed.add(onImageDisplayed);
            _tiles[0].loadImage();
        }

        private function onImageDisplayed(tile:CollageTileView):void {
            var tileIndex:int = _tiles.indexOf(tile);
            _tiles[tileIndex].imageDisplayed.remove(onImageDisplayed);
            _tiles[tileIndex].imageSelected.add(onImageSelected);

            if(++tileIndex < _tiles.length) {
                _tiles[tileIndex].imageDisplayed.add(onImageDisplayed);
                _tiles[tileIndex].loadImage();
            }
        }

        private function onImageSelected(tile:CollageTileView):void {
            _imageSelected.dispatch(Number(_tiles.indexOf(tile)));
        }

        public function loadNewImage(tileIndex:Number, newImage:IGalleryImage):void {
            _tiles[tileIndex].loadImage(newImage);
        }

        public function unloadAllTiles():void {
            if(this.numChildren != 0) {
                var tileToRemove:CollageTileView = this.getChildAt(0) as CollageTileView;
                tileToRemove.destroy();
                this.removeChild(tileToRemove);
            }
        }

        public function destroy():void {
            unloadAllTiles();
        }

        public function get imageSelected():Signal {
            return _imageSelected;
        }

        public function get dataProvider():Array {
            return _dataProvider;
        }

        public function set dataProvider(value:Array):void {
            if(_dataProvider != value) {
                _dataProvider = value;
                galleryUpdated();
            }
        }

        public function get bkpOrder():String {
            return _bkpOrder;
        }

        public function set bkpOrder(value:String):void {
            _bkpOrder = value;
        }
    }
}
