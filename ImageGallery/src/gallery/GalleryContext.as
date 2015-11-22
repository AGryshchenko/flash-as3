package gallery {
    import flash.display.DisplayObjectContainer;

    import gallery.controller.LoadGalleryCommand;
    import gallery.controller.SelectImageCommand;
    import gallery.controller.UpdateGalleryCommand;
    import gallery.model.GalleryModel;
    import gallery.model.factories.IGalleryFactory;
    import gallery.model.factories.XMLGalleryFactory;
    import gallery.service.IGalleryImageService;
    import gallery.service.XMLImageService;
    import gallery.signals.GalleryUpdatedSignal;
    import gallery.signals.LoadGallerySignal;
    import gallery.signals.LoadNewImageSignal;
    import gallery.signals.SelectImageSignal;
    import gallery.signals.UpdateGallerySignal;
    import gallery.view.components.IGalleryView;
    import gallery.view.mediators.ApplicationViewMediator;
    import gallery.view.mediators.GalleryViewMediator;

    import org.robotlegs.base.ViewInterfaceMediatorMap;
    import org.robotlegs.core.IMediatorMap;
    import org.robotlegs.mvcs.SignalContext;

    public class GalleryContext extends SignalContext {

        override protected function get mediatorMap():IMediatorMap {
            return _mediatorMap = new ViewInterfaceMediatorMap(contextView, createChildInjector(), reflector);
        }

        public function GalleryContext(contextView:DisplayObjectContainer) {
            super(contextView);
        }


        override public function startup():void {

            //map the presentation models
            injector.mapSingleton(GalleryModel);

            //map the services and their factories
            injector.mapSingletonOf(IGalleryImageService, XMLImageService);
            injector.mapSingletonOf(IGalleryFactory, XMLGalleryFactory);

            //map the signals
            injector.mapSingleton(GalleryUpdatedSignal);
            injector.mapSingleton(LoadNewImageSignal);

            signalCommandMap.mapSignalClass(LoadGallerySignal, LoadGalleryCommand);
            signalCommandMap.mapSignalClass(UpdateGallerySignal, UpdateGalleryCommand);
            signalCommandMap.mapSignalClass(SelectImageSignal, SelectImageCommand);

            //map view
            mediatorMap.mapView(IGalleryView, GalleryViewMediator);

            //map appView
            mediatorMap.mapView(Main, ApplicationViewMediator);
        }
    }
}