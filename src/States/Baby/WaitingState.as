import src.States.State;
class   src.States.Baby.WaitingState implements State {
	// Nothing to do for the waiting state.

	public function Enter():Void {

	 	}
    public function Exit():Void {


    }
    public function onEnterFrame():Void {


    }

    public function ExitFinished():Boolean {
    	return true;
    }
}
