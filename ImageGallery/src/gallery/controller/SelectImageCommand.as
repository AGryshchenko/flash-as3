package gallery.controller {
    import gallery.model.GalleryModel;
    import gallery.signals.LoadNewImageSignal;

    import org.robotlegs.mvcs.Command;

    /** This command is executed in response for selecting image by user and
     * is used to get next image and send it to view for displaying.*/
    public class SelectImageCommand extends Command {

        [Inject]
        public var imageSlotIndex:Number;

        [Inject]
        public var galleryModel:GalleryModel;

        [Inject]
        public var loadNewImage:LoadNewImageSignal;

        override public function execute():void {
            loadNewImage.dispatch(imageSlotIndex, galleryModel.randomImage());
        }
    }
}