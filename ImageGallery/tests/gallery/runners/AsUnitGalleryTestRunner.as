package gallery.runners {
	import asunit.textui.TestRunner;

	import gallery.suites.GalleryTestSuite;

	public class AsUnitGalleryTestRunner extends TestRunner {
		public function AsUnitGalleryTestRunner() {
			start(GalleryTestSuite, null, TestRunner.SHOW_TRACE);
		}
	}
}
