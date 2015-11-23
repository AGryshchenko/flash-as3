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

    [SWF(backgroundColor = "0x000000", width="300", height="300")]
    public class Tests extends Sprite {

        public function Tests() {

            //Debug info for memory management
            addChild(new Stats());


            //Tests should be run either in another
            new AsUnitGalleryTestRunner();
        }
    }
}
