/**
 * Created by Azure on 11/18/2015.
 */
package {
    import asunit.textui.TestRunner;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import gallery.GalleryContext;
    import gallery.runners.AsUnitGalleryTestRunner;
    import gallery.view.components.IGalleryView;
    import gallery.view.components.simpleGallery.SimpleGalleryView;
    import gallery.view.components.collageGallery.CollageGalleryView;
    import gallery.view.utils.bowcamp.BowcampOrders;

    import net.hires.debug.Stats;

    [SWF(backgroundColor = "0x000000", width="1280", height="900")]
    public class Main extends Sprite {
        public var context:GalleryContext;

        private var testRunner:TestRunner;


        public function Main() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            new AsUnitGalleryTestRunner();
            //context = new GalleryContext(this);

            //Debug info for memory management
            var resources:Stats = new Stats();
            addChild(resources);

            // Run tests
           // testRunner = new AsUnitGalleryTestRunner();
        }

        public function createView():void {
            var galleryView:CollageGalleryView = new CollageGalleryView(BowcampOrders.RECT_CODE_12);
            //var galleryView:SimpleGalleryView = new SimpleGalleryView();
            addChild(galleryView);

        }
    }
}
