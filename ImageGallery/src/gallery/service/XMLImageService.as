package gallery.service {
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import gallery.model.factories.IGalleryFactory;
    import gallery.model.vo.Gallery;
    import gallery.signals.UpdateGallerySignal;

    import org.robotlegs.mvcs.Actor;

    /** This class represents service in MVCS model. The purpose of this class is loading a list of images
     * that should be used as images for gallery. The list is parsed with IGalleryFactory,
     * then the list dispatched with signal to controller.*/
    public class XMLImageService extends Actor implements IGalleryImageService {
        [Inject]
        public var galleryFactory:IGalleryFactory;

        [Inject]
        public var updateGallery:UpdateGallerySignal;

        protected static const BASE_URL:String = "assets/gallery/";


        public function XMLImageService() {
            super();
        }

        public function loadGallery():void {
            var xmlLoader:URLLoader = new URLLoader();
            xmlLoader.addEventListener(Event.COMPLETE, handleServiceResult);
            xmlLoader.addEventListener(ErrorEvent.ERROR, handleServiceFault);
            xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleServiceFault);
            xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleServiceFault);
            xmlLoader.load(new URLRequest(BASE_URL + "gallery.xml"));
        }

        protected function handleServiceResult(event:Object):void {
            event.target.removeEventListener(Event.COMPLETE, handleServiceResult);
            event.target.removeEventListener(ErrorEvent.ERROR, handleServiceFault);
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, handleServiceFault);
            event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleServiceFault);
            var urlXML:XML = new XML(event.target.data);
            var gallery:Gallery = galleryFactory.createGallery(urlXML.image, BASE_URL);
            updateGallery.dispatch(gallery);
        }

        protected function handleServiceFault(event:Object):void {
            event.target.removeEventListener(Event.COMPLETE, handleServiceResult);
            event.target.removeEventListener(ErrorEvent.ERROR, handleServiceFault);
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, handleServiceFault);
            event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleServiceFault);
            trace(event);
        }
    }
}