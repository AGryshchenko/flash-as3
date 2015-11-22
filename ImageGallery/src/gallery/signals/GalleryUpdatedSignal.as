package gallery.signals {
    import gallery.model.vo.IGallery;

    import org.osflash.signals.Signal;

    public class GalleryUpdatedSignal extends Signal {
        public function GalleryUpdatedSignal() {
            super(IGallery);
        }
    }
}