import src.States.State;
class   src.States.Baby.WaitingState implements State {
	 public function Enter():Void {
	 	trace("Waiting Enter");
	 	}
    public function Exit():Void {
    	trace("Waiting Exit");

    }
    public function onEnterFrame():Void {
    	trace("Waiting");

    }

    public function ExitFinished():Boolean {
    	return true;
    }
}
