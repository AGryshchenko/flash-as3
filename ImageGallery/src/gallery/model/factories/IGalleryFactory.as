package gallery.model.factories {
    import gallery.model.vo.Gallery;

    public interface IGalleryFactory {
        function createGallery(input:Object, baseURL:String = ""):Gallery;
    }
}