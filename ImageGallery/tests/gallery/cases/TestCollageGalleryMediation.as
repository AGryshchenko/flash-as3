package gallery.cases {
    import asunit.framework.Assert;
    import asunit.framework.TestCase;

    import gallery.model.vo.Gallery;
    import gallery.model.vo.GalleryImage;
    import gallery.signals.GalleryUpdatedSignal;
    import gallery.signals.LoadGallerySignal;
    import gallery.signals.LoadNewImageSignal;
    import gallery.signals.SelectImageSignal;
    import gallery.view.components.collageGallery.CollageGalleryView;
    import gallery.view.components.collageGallery.CollageTileView;
    import gallery.view.mediators.GalleryViewMediator;
    import gallery.view.utils.bowcamp.BowcampOrders;

    public class TestCollageGalleryMediation extends TestCase {
        private var galleryViewMediator:GalleryViewMediator;
        private var simpleGalleryView:CollageGalleryView;
        private var testImage1:GalleryImage;
        private var testImage2:GalleryImage;
        private var testGallery:Gallery;
        private var testTile:CollageTileView;

        public function TestCollageGalleryMediation(methodName:String = null) {
            super(methodName);
        }

        [Before]
        override protected function setUp():void {
            this.simpleGalleryView = new CollageGalleryView(BowcampOrders.RECT_CODE_9);
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
            this.testTile = new CollageTileView();
            this.testTile.galleryImage = this.testImage1;
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
                    this.galleryViewMediator.galleryView.dataProvider, testGallery.photos);
        }
    }
}