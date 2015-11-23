package gallery.controller {
    import gallery.service.IGalleryImageService;

    import org.robotlegs.mvcs.Command;

    /** This command is executed when view is ready,
     * and it initialises loading of gallery data by  gallery service.*/
    public class LoadGalleryCommand extends Command {
        [Inject]
        public var service:IGalleryImageService;

        override public function execute():void {
            service.loadGallery();
        }
    }
}