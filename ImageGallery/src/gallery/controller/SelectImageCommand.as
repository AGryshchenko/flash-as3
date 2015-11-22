package gallery.controller {
    import gallery.model.GalleryModel;
    import gallery.signals.LoadNewImageSignal;

    import org.robotlegs.mvcs.Command;

    /**
     * This is a chained command. It is used to remove selected image from model,
     * and swap removed image with new image in view*/
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