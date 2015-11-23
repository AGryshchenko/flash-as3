package gallery.controller {
    import gallery.model.GalleryModel;
    import gallery.model.vo.IGallery;
    import gallery.signals.GalleryUpdatedSignal;

    import org.robotlegs.mvcs.Command;

    /** This command is executed in response of model signal,
     * and informs view that new data is available for display.*/
    public class UpdateGalleryCommand extends Command {
        [Inject]
        public var gallery:IGallery;

        [Inject]
        public var galleryModel:GalleryModel;

        [Inject]
        public var galleryUpdated:GalleryUpdatedSignal;

        override public function execute():void {
            galleryModel.gallery = gallery;
            galleryUpdated.dispatch(galleryModel.gallery);
        }
    }
}