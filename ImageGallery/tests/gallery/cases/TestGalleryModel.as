package gallery.cases {
    import asunit.framework.Assert;
    import asunit.framework.TestCase;

    import gallery.model.GalleryModel;
    import gallery.model.vo.Gallery;
    import gallery.model.vo.GalleryImage;
    import gallery.model.vo.IGalleryImage;

    public class TestGalleryModel extends TestCase {
        private var galleryModel:GalleryModel;


        public function TestGalleryModel(methodName:String = null) {
            super(methodName);
        }

        [Before]
        override protected function setUp():void {
            this.galleryModel = new GalleryModel()
        }

        [After]
        override protected function tearDown():void {
            this.galleryModel = null;
        }

        [Test]
        public function testSetGallery():void {
            var gallery:Gallery = new Gallery();
            this.galleryModel.gallery = gallery;
            Assert.assertEquals("galleryModel should have a gallery",
                    this.galleryModel.gallery != null, true);
        }

        [Test]
        public function testRandomImage():void {
            var image1:GalleryImage = new GalleryImage();
            var image2:GalleryImage = new GalleryImage();
            var randomImage:IGalleryImage = null;
            var gallery:Gallery = new Gallery();
            this.galleryModel.gallery = gallery;
            gallery.photos.push(image1);
            gallery.photos.push(image2);
            image1.URL = "image1Test";
            image2.URL = "image2Test";
            randomImage = this.galleryModel.randomImage();
            Assert.assertTrue("RandomImage returns one of added images", randomImage == image1 || randomImage == image2);
        }
    }
}