package gallery.cases {
    import asunit.framework.Assert;
    import asunit.framework.TestCase;

    import gallery.model.vo.Gallery;
    import gallery.model.vo.GalleryImage;
    import gallery.signals.GalleryUpdatedSignal;
    import gallery.signals.ViewInitializedSignal;
    import gallery.signals.LoadNewImageSignal;
    import gallery.signals.ImageSelectedSignal;
    import gallery.view.components.simpleGallery.SimpleGalleryView;
    import gallery.view.components.simpleGallery.SimpleTileView;
    import gallery.view.mediators.GalleryViewMediator;

    public class TestSimpleGalleryMediation extends TestCase {
        private var galleryViewMediator:GalleryViewMediator;
        private var simpleGalleryView:SimpleGalleryView;
        private var testImage1:GalleryImage;
        private var testImage2:GalleryImage;
        private var testGallery:Gallery;

        public function TestSimpleGalleryMediation(methodName:String = null) {
            super(methodName);
        }

        [Before(async, ui)]
        override protected function setUp():void {
            this.simpleGalleryView = new SimpleGalleryView();
            this.galleryViewMediator = new GalleryViewMediator();
            this.galleryViewMediator.setViewComponent(this.simpleGalleryView);
            this.galleryViewMediator.galleryView = this.simpleGalleryView;
            this.galleryViewMediator.viewInitialized = new ViewInitializedSignal();
            this.galleryViewMediator.galleryUpdated = new GalleryUpdatedSignal();
            this.galleryViewMediator.imageSelected = new ImageSelectedSignal();
            this.galleryViewMediator.loadNewImage = new LoadNewImageSignal();
            this.galleryViewMediator.onRegister();

            this.testImage1 = new GalleryImage();
            this.testImage2 = new GalleryImage();
            this.testImage1.URL = "assets/gallery/images/3354402351_cf6797c126.jpg";
            this.testImage2.URL = "assets/gallery/images/3355136923_3cbe01c482.jpg";
            this.testGallery = new Gallery();
            this.testGallery.photos.push(this.testImage1);
            this.testGallery.photos.push(this.testImage2);
        }

        [After]
        override protected function tearDown():void {
            this.simpleGalleryView = null;
            this.galleryViewMediator.onRemove();
            this.galleryViewMediator.setViewComponent(null);
            this.galleryViewMediator.eventDispatcher = null;
            this.galleryViewMediator = null;
        }

        [Test]
        public function testMediatorHasViewComponent():void {
            Assert.assertNotNull(this.galleryViewMediator.galleryView);
            Assert.assertNotNull(this.galleryViewMediator.getViewComponent());
        }

        [Test]
        public function testUpdateGallery():void {
            this.galleryViewMediator.galleryUpdated.dispatch(this.testGallery);
            Assert.assertEquals("Test that gallery from galleryUpdated signal corresponds gallery in view\'s dataProvider",
                    this.galleryViewMediator.galleryView.dataProvider, this.testGallery.photos);
        }

    }
}