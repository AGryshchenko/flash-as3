package gallery.cases {
    import asunit.framework.Assert;
    import asunit.framework.TestCase;

    import gallery.model.factories.XMLGalleryFactory;
    import gallery.model.vo.Gallery;
    import gallery.service.XMLImageService;
    import gallery.signals.UpdateGallerySignal;

    public class TestXMLImageService extends TestCase {
        private var service:XMLImageService;

        public function TestXMLImageService(methodName:String = null) {
            super(methodName);
        }

        [Before]
        override protected function setUp():void {
            super.setUp();
            this.service = new XMLImageService();
            this.service.galleryFactory = new XMLGalleryFactory();
            this.service.updateGallery = new UpdateGallerySignal();
        }

        [After]
        override protected function tearDown():void {
            this.service = null;
        }

        [Test]
        public function testRetrieveImages():void {
            this.service.updateGallery.add(handleImagesReceived);

            this.service.loadGallery();
        }

        protected function handleImagesReceived(gallery:Gallery):void {
            Assert.assertEquals("The gallery should have some photos: ",
                    gallery.photos.length > 0, true)
        }


    }
}