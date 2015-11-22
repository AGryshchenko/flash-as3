package gallery.view.mediators {
    import org.robotlegs.mvcs.Mediator;

    public class ApplicationViewMediator extends Mediator {
        [Inject]
        public var appView:Main;

        override public function onRegister():void {
            appView.createView();
        }
    }
}