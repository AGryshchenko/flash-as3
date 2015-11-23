package gallery.view.mediators {
    import org.robotlegs.mvcs.Mediator;

    /** Class is used as mediator for main application and is ised to initialize view*/
    public class ApplicationViewMediator extends Mediator {
        [Inject]
        public var appView:Main;

        override public function onRegister():void {
            appView.createView();
        }
    }
}