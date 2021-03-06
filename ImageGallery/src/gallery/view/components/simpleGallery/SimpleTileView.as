package gallery.view.components.simpleGallery {
    import com.greensock.TweenLite;

    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.events.AsyncErrorEvent;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;

    import gallery.model.vo.IGalleryImage;

    import org.osflash.signals.Signal;

    /** This is a view for image tile in Simple view gallery.
     *  This tile is used to show image, show preloader and
     *  dispatch selected signals to parent gallery view. */
    public class SimpleTileView extends SimpleTile {

        private static const IMAGE_BUFFER_LENGTH:uint = 1;

        private static const TILE_BORDER_WIDTH:uint = 10;

        private var _tileIndex:Number;

        private var _galleryImage:IGalleryImage;

        private var _loader:Loader;

        private var _loadedImages:Vector.<BufferedImage> = new Vector.<BufferedImage>();


        public var imageSelected:Signal = new Signal(SimpleTileView);

        [Inject]
        public var loaderContext:LoaderContext;

        public function loadImage(galleryImage:IGalleryImage):void {
            _galleryImage = galleryImage;
            var imageRequest:URLRequest = new URLRequest(_galleryImage.URL);
            _loader = new Loader();
            addContentListeners(_loader.contentLoaderInfo);
            removeEventListener(MouseEvent.CLICK, onImageSelected);
            _loader.load(imageRequest, loaderContext);
            showPreloader();
        }

        private function onLoadCompleted(event:Event):void {
            removeContentListeners(_loader.contentLoaderInfo);
            showImage(_loader.content as Bitmap);
            _loader.unload();
        }

        private function showImage(image:Bitmap):void {
            var widthRatio:Number = imageMask.width / image.width;
            var heightRatio:Number = imageMask.height / image.height;
            image.scaleX = image.scaleY *= Math.max(widthRatio, heightRatio);
            smoothImage(image);
            displayImage(image);
        }

        private function smoothImage(image:Object):void {
            if(!(image is Bitmap)) return;

            var bitmap:Bitmap = image as Bitmap;

            if(bitmap != null && bitmap.smoothing == false) {
                bitmap.smoothing = true;
            }
        }

        private function displayImage(image:Bitmap):void {
            _loadedImages.unshift(new BufferedImage(image, _galleryImage));

            image.alpha = 0;
            holder.addChild(image);
            if(_loadedImages.length > 1) {
                TweenLite.to(_loadedImages[1].bitmap, 1, {alpha: 0, onComplete: removeExtraImages});
            }
            hidePreloader();
            TweenLite.to(image, 1, {alpha: 1, onComplete: onImageDisplayed});
        }

        private function removeExtraImages():void {
            if(_loadedImages.length > IMAGE_BUFFER_LENGTH) {
                unloadBitmap(_loadedImages.pop().bitmap);
            }
        }

        private function unloadBitmap(bmpToRemove:Bitmap):void {
            holder.removeChild(bmpToRemove);
        }

        private function hidePreloader():void {
            TweenLite.to(preloader, .25, {alpha: 0});
        }

        private function showPreloader():void {
            TweenLite.to(preloader, .25, {alpha: 1});
            gotoAndPlay(0);
        }

        private function onImageDisplayed():void {
            addEventListener(MouseEvent.CLICK, onImageSelected);
        }

        private function onImageSelected(event:MouseEvent):void {
            imageSelected.dispatch(this);
        }


        private function addContentListeners(contentInfo:IEventDispatcher):void {
            contentInfo.addEventListener(Event.COMPLETE, onLoadCompleted);
            contentInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
            contentInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
            contentInfo.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onError);
        }

        private function removeContentListeners(contentInfo:IEventDispatcher):void {
            contentInfo.removeEventListener(Event.COMPLETE, onLoadCompleted);
            contentInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
            contentInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
            contentInfo.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onError);
        }

        private function onError(event:Event):void {
            trace(event);
            removeContentListeners(_loader.contentLoaderInfo);
        }

        public function destroy():void {
            if(_loader) {
                removeContentListeners(_loader.contentLoaderInfo);
                _loader.unload();
            }
            for each(var buffImage:BufferedImage in _loadedImages) {
                unloadBitmap(buffImage.bitmap);
            }
            imageSelected.removeAll();
            removeEventListener(MouseEvent.CLICK, onImageSelected);
        }


        public function get tileIndex():Number {
            return _tileIndex;
        }

        public function set tileIndex(value:Number):void {
            _tileIndex = value;
        }

        public function get galleryImage():IGalleryImage {
            return _galleryImage;
        }

        public function set galleryImage(value:IGalleryImage):void {
            _galleryImage = value;
        }
    }
}

import flash.display.Bitmap;

import gallery.model.vo.IGalleryImage;

class BufferedImage {
    public var bitmap:Bitmap;
    public var galleryImage:IGalleryImage;

    public function BufferedImage(bitmap:Bitmap, galleryImage:IGalleryImage) {
        this.bitmap = bitmap;
        this.galleryImage = galleryImage;
    }
}