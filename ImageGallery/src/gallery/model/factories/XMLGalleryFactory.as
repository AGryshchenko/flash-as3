package gallery.model.factories {
    import flash.errors.IOError;

    import gallery.model.vo.Gallery;
    import gallery.model.vo.GalleryImage;

    public class XMLGalleryFactory implements IGalleryFactory {

        public function createGallery(input:Object, baseURL:String = ""):Gallery {
            var gallery:Gallery = new Gallery();

            if(!(input is XMLList))
                throw new IOError("input must be XMLList")

            for each(var image:XML in input) {
                var photo:GalleryImage = new GalleryImage()
                photo.URL = baseURL + "images/" + image.@name + '.jpg';
                gallery.photos.push(photo);
            }

            return gallery;
        }
    }
}