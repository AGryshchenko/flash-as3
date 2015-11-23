package gallery.view.components.simpleGallery {
    import flash.display.Sprite;

    import gallery.model.vo.GalleryImage;
    import gallery.model.vo.IGalleryImage;
    import gallery.view.components.*;

    import org.osflash.signals.Signal;

    /** This class represents view for simple gallery.
     * It controls the order of displaying of tiles on the screen.
     * Also this class dispatches image selected event,
     * so that controller can apply appropriate logic on this signal.*/
    public class SimpleGalleryView extends Sprite implements IGalleryView {

        private static const VIEW_WIDTH:uint = 610;
        private static const TILE_SPACING:uint = 10;

        private var _dataProvider:Array;

        private var _imageSelected:Signal = new Signal(Number);

        private var _tiles:Vector.<SimpleTileView> = new Vector.<SimpleTileView>();

        private function galleryUpdated():void {
            unloadAllTiles();

            var tileX:Number = TILE_SPACING;
            var tileY:Number = TILE_SPACING;
            var tile:SimpleTileView;
            for each(var image:GalleryImage in dataProvider) {
                tile = new SimpleTileView();
                _tiles.push(tile);
                tile.x = tileX;
                tile.y = tileY;
                tile.imageSelected.add(onImageSelected);
                tile.loadImage(image);
                this.addChild(tile);
                if(_tiles.length >= 9) break;
                //Calculate x and y for next tile
                tileX += tile.width + TILE_SPACING;
                if(tileX >= VIEW_WIDTH) {
                    tileX = TILE_SPACING;
                    tileY += tile.height + TILE_SPACING;
                }
            }
        }

        private function onImageSelected(tile:SimpleTileView):void {
            _imageSelected.dispatch(_tiles.indexOf(tile));
        }

        public function loadNewImage(tileIndex:Number, newImage:IGalleryImage):void {
            _tiles[tileIndex].loadImage(newImage);
        }

        public function unloadAllTiles():void {
            if(this.numChildren != 0) {
                var tileToRemove:SimpleTileView = this.getChildAt(0) as SimpleTileView;
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
    }
}
