package gallery.view.mediators {
    import gallery.model.vo.Gallery;
    import gallery.model.vo.IGalleryImage;
    import gallery.signals.GalleryUpdatedSignal;
    import gallery.signals.ImageSelectedSignal;
    import gallery.signals.LoadNewImageSignal;
    import gallery.signals.ViewInitializedSignal;
    import gallery.view.components.IGalleryView;

    import org.robotlegs.mvcs.Mediator;

    /** Class represents Mediator in MVCS model and can mediate IGalleryView*/
    public class GalleryViewMediator extends Mediator {
        [Inject]
        public var viewInitialized:ViewInitializedSignal;

        [Inject]
        public var galleryUpdated:GalleryUpdatedSignal;

        [Inject]
        public var imageSelected:ImageSelectedSignal;

        [Inject]
        public var loadNewImage:LoadNewImageSignal;

        [Inject]
        public var galleryView:IGalleryView;

        override public function onRegister():void {
            galleryUpdated.add(onGalleryUpdated);
            loadNewImage.add(onLoadNewImage);
            galleryView.imageSelected.add(handleImageSelected);
            viewInitialized.dispatch();
        }

        protected function onGalleryUpdated(gallery:Gallery):void {
            galleryView.dataProvider = gallery.photos;
        }

        protected function onLoadNewImage(imageSlotIndex:Number, newImage:IGalleryImage):void {
            galleryView.loadNewImage(imageSlotIndex, newImage);
        }

        protected function handleImageSelected(index:Number):void {
            imageSelected.dispatch(index);
        }

        override public function onRemove():void {
            viewInitialized.removeAll();
            galleryUpdated.removeAll();
            imageSelected.removeAll();
            loadNewImage.removeAll();
            galleryView.destroy();
        }
    }
}