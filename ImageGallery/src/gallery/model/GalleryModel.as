package gallery.model {
    import gallery.model.vo.IGallery;
    import gallery.model.vo.IGalleryImage;

    import org.robotlegs.mvcs.*;

    /** This class is used to store and retrieve data, that are needed for the gallery.*/
    public class GalleryModel extends Actor {

        private var _gallery:IGallery;

        public function GalleryModel() {

        }

        public function get gallery():IGallery {
            return this._gallery;
        }

        public function set gallery(v:IGallery):void {
            this._gallery = v;
        }

        public function randomImage():IGalleryImage {
            var imageIndex:uint = Math.floor(Math.random() * gallery.photos.length);
            return gallery.photos[imageIndex];
        }
    }
}