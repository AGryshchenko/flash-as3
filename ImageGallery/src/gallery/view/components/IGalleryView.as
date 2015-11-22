package gallery.view.components {
    import gallery.model.vo.IGalleryImage;

    import org.osflash.signals.Signal;

    public interface IGalleryView {
        function loadNewImage(tileIndex:Number, newImage:IGalleryImage):void;

        function destroy():void

        function get imageSelected():Signal;

        function get dataProvider():Array;

        function set dataProvider(value:Array):void;
    }
}
