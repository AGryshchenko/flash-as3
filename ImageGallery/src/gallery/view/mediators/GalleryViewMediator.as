package gallery.view.mediators {
    import gallery.model.vo.Gallery;
    import gallery.model.vo.IGalleryImage;
    import gallery.signals.GalleryUpdatedSignal;
    import gallery.signals.LoadGallerySignal;
    import gallery.signals.LoadNewImageSignal;
    import gallery.signals.SelectImageSignal;
    import gallery.view.components.IGalleryView;

    import org.robotlegs.mvcs.Mediator;

    public class GalleryViewMediator extends Mediator {
        [Inject]
        public var loadGallery:LoadGallerySignal;

        [Inject]
        public var galleryUpdated:GalleryUpdatedSignal;

        [Inject]
        public var selectImage:SelectImageSignal;

        [Inject]
        public var loadNewImage:LoadNewImageSignal;

        [Inject]
        public var galleryView:IGalleryView;

        override public function onRegister():void {
            galleryUpdated.add(onGalleryUpdated);
            loadNewImage.add(onLoadNewImage);
            galleryView.imageSelected.add(handleImageSelected);
            loadGallery.dispatch();
        }

        protected function onGalleryUpdated(gallery:Gallery):void {
            galleryView.dataProvider = gallery.photos;
        }

        protected function onLoadNewImage(imageSlotIndex:uint, newImage:IGalleryImage):void {
            galleryView.loadNewImage(imageSlotIndex, newImage);
        }

        protected function handleImageSelected(index:Number):void {
            selectImage.dispatch(index);
        }

        override public function onRemove():void {
            loadGallery.removeAll();
            galleryUpdated.removeAll();
            selectImage.removeAll();
            loadNewImage.removeAll();
            galleryView.destroy();
        }
    }
}