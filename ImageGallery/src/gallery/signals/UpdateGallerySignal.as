package gallery.signals {
    import gallery.model.vo.IGallery;

    import org.osflash.signals.Signal;

    /** This signal is dispatched by controller to inform
     *  view that new data from model is ready and can be displayed.*/
    public class UpdateGallerySignal extends Signal {
        public function UpdateGallerySignal() {
            super(IGallery);
        }
    }
}