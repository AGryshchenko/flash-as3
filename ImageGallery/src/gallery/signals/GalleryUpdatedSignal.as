package gallery.signals {
    import gallery.model.vo.IGallery;

    import org.osflash.signals.Signal;

    /** This signal is dispatched by model to inform controller that new data for gallery is available.*/
    public class GalleryUpdatedSignal extends Signal {
        public function GalleryUpdatedSignal() {
            super(IGallery);
        }
    }
}