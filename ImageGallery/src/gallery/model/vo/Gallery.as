package gallery.model.vo {
    public class Gallery implements IGallery {
        private var _photos:Array = new Array()

        public function get photos():Array {
            return _photos;
        }

        public function set photos(value:Array):void {
            _photos = value;
        }

    }
}