package gallery.cases {
    import asunit.framework.Assert;
    import asunit.framework.TestCase;

    import gallery.model.vo.Gallery;
    import gallery.model.vo.GalleryImage;
    import gallery.signals.GalleryUpdatedSignal;
    import gallery.signals.LoadGallerySignal;
    import gallery.signals.LoadNewImageSignal;
    import gallery.signals.SelectImageSignal;
    import gallery.view.components.simpleGallery.SimpleGalleryView;
    import gallery.view.components.simpleGallery.SimpleTileView;
    import gallery.view.mediators.GalleryViewMediator;

    public class TestSimpleGalleryMediation extends TestCase {
        private var galleryViewMediator:GalleryViewMediator;
        private var simpleGalleryView:SimpleGalleryView;
        private var testImage1:GalleryImage;
        private var testImage2:GalleryImage;
        private var testGallery:Gallery;
        private var testTile:SimpleTileView;

        public function TestSimpleGalleryMediation(methodName:String = null) {
            super(methodName);
        }

        [Before(async, ui)]
        override protected function setUp():void {
            this.simpleGalleryView = new SimpleGalleryView();
            this.galleryViewMediator = new GalleryViewMediator();
            this.galleryViewMediator.setViewComponent(this.simpleGalleryView);
            this.galleryViewMediator.galleryView = this.simpleGalleryView;
            this.galleryViewMediator.loadGallery = new LoadGallerySignal();
            this.galleryViewMediator.galleryUpdated = new GalleryUpdatedSignal();
            this.galleryViewMediator.selectImage = new SelectImageSignal();
            this.galleryViewMediator.loadNewImage = new LoadNewImageSignal();
            this.galleryViewMediator.onRegister();

            this.testImage1 = new GalleryImage();
            this.testImage2 = new GalleryImage();
            this.testImage1.URL = "image1Test";
            this.testImage2.URL = "image2Test";
            this.testGallery = new Gallery();
            this.testGallery.photos.push(this.testImage1);
            this.testGallery.photos.push(this.testImage2);
            this.testTile = new SimpleTileView();
            this.testTile.galleryImage = testImage1;
        }

        [After]
        override protected function tearDown():void {
            this.simpleGalleryView = null;
            this.galleryViewMediator.onRemove();
            this.galleryViewMediator.setViewComponent(null);
            this.galleryViewMediator.eventDispatcher = null;
            this.galleryViewMediator = null;
            if(this.testTile)
            {
                this.testTile.destroy();
            }
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