package gallery.cases {
    import asunit.framework.Assert;
    import asunit.framework.TestCase;

    import gallery.view.utils.bowcamp.BowcampOrderObject;
    import gallery.view.utils.bowcamp.BowcampOrders;
    import gallery.view.utils.bowcamp.BowcampSquareTileObject;

    public class TestBowcampOrderObject extends TestCase {
        private var bkpObject:BowcampOrderObject;


        public function TestBowcampOrderObject(methodName:String = null) {
            super(methodName);
        }

        [Before]
        override protected function setUp():void {
            this.bkpObject = new BowcampOrderObject(BowcampOrders.RECT_CODE_9, 100);
        }


        [Test]
        public function testHasNextTileObject():void {
            this.bkpObject = new BowcampOrderObject(BowcampOrders.RECT_CODE_9, 100);
            Assert.assertTrue("Tests that bkp object has next tile object", this.bkpObject.hasNextTileObject());
        }

        [Test]
        public function testNotHasNextTileObject():void {
            this.bkpObject = new BowcampOrderObject("5 6 4", 100);
            Assert.assertFalse("Tests that bkp object has next tile object", this.bkpObject.hasNextTileObject());
        }

        [Test]
        public function testFirstTileObject():void {
            this.bkpObject = new BowcampOrderObject(BowcampOrders.RECT_CODE_9, 100);
            var nextBkp:BowcampSquareTileObject = this.bkpObject.nextTileObject();
            Assert.assertEquals("Tests that first tile object X value is correct", nextBkp.tileX, 0);
            Assert.assertEquals("Tests that first tile object Y value is correct", nextBkp.tileY, 0);
            Assert.assertEquals("Tests that first tile object Size value is correct", nextBkp.tileSize, 600);
        }

        [Test]
        public function testThirdTileObject():void {
            this.bkpObject = new BowcampOrderObject(BowcampOrders.RECT_CODE_9, 100);
            this.bkpObject.nextTileObject(); // skip first object
            this.bkpObject.nextTileObject(); // skip second object
            var nextBkp:BowcampSquareTileObject = this.bkpObject.nextTileObject();
            Assert.assertEquals("Tests that third tile object X value is correct", nextBkp.tileX, 1000);
            Assert.assertEquals("Tests that third tile object Y value is correct", nextBkp.tileY, 0);
            Assert.assertEquals("Tests that third tile object Size value is correct", nextBkp.tileSize, 500);
        }
    }
}