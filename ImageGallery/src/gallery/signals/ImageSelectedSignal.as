package gallery.signals {
    import org.osflash.signals.Signal;


    /** This signal is dispatched by view when user clicks on image*/
    public class ImageSelectedSignal extends Signal {
        public function ImageSelectedSignal() {
            super(Number);
        }
    }
}