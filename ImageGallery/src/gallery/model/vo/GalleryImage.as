package gallery.model.vo {
    public class GalleryImage implements IGalleryImage {
        protected var _URL:String;

        public function get URL():String {
            return _URL;
        }

        public function set URL(v:String):void {
            _URL = v;
        }
    }
}