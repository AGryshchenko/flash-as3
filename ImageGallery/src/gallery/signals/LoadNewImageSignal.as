package gallery.signals {
    import gallery.model.vo.IGalleryImage;

    import org.osflash.signals.Signal;

    public class LoadNewImageSignal extends Signal {
        public function LoadNewImageSignal() {
            super(Object, IGalleryImage);
        }
    }
}