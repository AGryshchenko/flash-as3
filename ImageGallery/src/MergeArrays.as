/**
 * Created by Azure on 11/23/2015.
 */
package {
    import flash.display.Sprite;

    public class MergeArrays extends Sprite{


        public function MergeArrays() {
            var a:Array = [1, 2, 5, 7, 9, 13];
            var b:Array = [3, 4, 5, 6, 8, 9, 11, 12];
            trace(MergeArrays.mergeArrays(a, b).toString())
        }

        public static function mergeArrays(a1:Array, a2:Array):Array
        {
            var result:Array = new Array(a1.length + a2.length);
            var i:int = a1.length - 1, j:int = a2.length - 1;
            var k:int = result.length;

            while(k > 0)
                result[--k] = (j < 0 || (i >= 0 && a1[i] >= a2[j])) ? a1[i--] : a2[j--];

            return result;
        }
    }
}
