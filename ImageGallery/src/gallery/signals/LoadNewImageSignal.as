package gallery.signals {
    import gallery.model.vo.IGalleryImage;

    import org.osflash.signals.Signal;

    /** Signal is dispatched from controller to inform view that new
     *  image should be loaded in specific position*/
    public class LoadNewImageSignal extends Signal {
        public function LoadNewImageSignal() {
            super(Number, IGalleryImage);
        }
    }
}