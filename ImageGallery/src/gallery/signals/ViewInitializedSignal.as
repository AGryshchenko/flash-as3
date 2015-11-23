package gallery.signals {
    import org.osflash.signals.Signal;

    /** This signal is dispatched by view mediator to inform
     *  that it is ready to receive new data from model */
    public class ViewInitializedSignal extends Signal {
        public function ViewInitializedSignal() {
            super();
        }
    }
}