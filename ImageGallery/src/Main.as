package {

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import gallery.GalleryContext;
    import gallery.view.components.collageGallery.CollageGalleryView;
    import gallery.view.components.simpleGallery.SimpleGalleryView;
    import gallery.view.utils.bowcamp.BowcampOrders;

    import net.hires.debug.Stats;

    /** This is the main class of Gallery application. From this class specific gallery view can be loaded.
     * Gallery supports 2 distinctive view: SimpleGalleryView and CollageGalleryView.
     * Please note, that for CollageGalleryView an argument in constructor specifies the layout of tiles.
     * There are 3 square and 3 rectangular layouts available, they are stored as constants in  BowcampOrders.
     * Also debug popup is loaded in this class, it is purely for viewing memory usage purposes.*/
    [SWF(backgroundColor="0xffffff", width="1280", height="900")]
    public class Main extends Sprite {
        public var context:GalleryContext;


        public function Main() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            //Gallery context
            context = new GalleryContext(this);

            //Debug info for memory management
            addChild(new Stats());
        }


        /** Creates specific view class and adds it to stage*/
        public function createView():void {
            var minTileSize:Number = 40; // minimal size of photo in pixels
            var galleryView:CollageGalleryView = new CollageGalleryView(BowcampOrders.RECT_CODE_12, minTileSize);
            //var galleryView:SimpleGalleryView = new SimpleGalleryView();
            addChild(galleryView);

        }
    }
}
