package gallery.signals {
    import gallery.model.vo.IGallery;

    import org.osflash.signals.Signal;

    public class UpdateGallerySignal extends Signal {
        public function UpdateGallerySignal() {
            super(IGallery);
        }
    }
}