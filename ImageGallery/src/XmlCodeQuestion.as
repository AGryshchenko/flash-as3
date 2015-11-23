package {
    import flash.display.Sprite;

    import gallery.runners.AsUnitGalleryTestRunner;

    import net.hires.debug.Stats;

    [SWF(backgroundColor="0x000000", width="300", height="300")]
    public class XmlCodeQuestion extends Sprite {


        /** This function calculates the remainder of value of attribute "myVal" divisible by 2
         *  and prints the value of "myVal" if rest is not 0.
         *  This the syntax "xmlData.children().(@myVal % 2 && trace(@myVal))"
         *  is ECMAScript for XML, known as e4x.
         *  .(@myVal % 2 && trace(@myVal)) is filtering predicate operator,
         *  that filters XMLList returned by xmlData.children() even further.
         *  essentially filtering boils down to
         *
         *  var result:XMLList = new XMLList();
         *  for each (var node:XML in target) {
         *      with (node) {
		 *          if (condition) {
		 *              result += node;
		 *          }
		 *      }
		 *  }
         * return result;
         *
         * Usually filtering expression is used to filter values,
         * and executing "trace" has nothing to do with filtering,
         * so that answers the question "what is wrong with the code?"
         * */
        public function XmlCodeQuestion() {

            var xmlData:XML =
                    <root>
                        <node myVal="1"> data </node>
                        <node myVal="2"> data </node>
                        <node myVal="3"> data </node>
                        <node myVal="4"> data </node>
                        <node myVal="5"> data </node>
                    </root>;

            xmlData.children().(@myVal % 2 && trace(@myVal));

        }
    }
}
