package gallery.suites {
    import asunit.framework.TestSuite;

    import gallery.cases.TestBowcampOrderObject;
    import gallery.cases.TestCollageGalleryMediation;
    import gallery.cases.TestGalleryModel;
    import gallery.cases.TestSimpleGalleryMediation;
    import gallery.cases.TestXMLImageService;

    public class GalleryTestSuite extends TestSuite {

        public function GalleryTestSuite() {
            super();
            addTest(new TestXMLImageService());
            addTest(new TestGalleryModel());
            addTest(new TestCollageGalleryMediation());
            addTest(new TestSimpleGalleryMediation());
            addTest(new TestBowcampOrderObject());
        }
    }
}