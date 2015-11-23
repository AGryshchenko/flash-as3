package {
    import flash.display.Sprite;

    import gallery.runners.AsUnitGalleryTestRunner;

    import net.hires.debug.Stats;

    [SWF(backgroundColor="0x000000", width="300", height="300")]
    public class Tests extends Sprite {

        public function Tests() {

            //Debug info for memory management
            addChild(new Stats());


            //Run tests
            new AsUnitGalleryTestRunner();
        }
    }
}
