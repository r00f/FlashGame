import src.States.State;
class src.States.StateMachine {
	private var states:Object = new Object();

	private var activeState:State; 
	private var nextState:String;

	public function RegisterState(name:String, state:State) {
		trace("Registered State:" + name + ": " + state);
		this.states[name] = state;
		trace(this.states[name]);
	}

	public function EnterState(name) {
		trace("StateMachine.EnterState")
		if (this.states[name] != undefined) {
			this.nextState = name;
		} else {
			trace("State '" + name + "'' does not exist in " + this);
		}
	}

	private function enterNextState() {
		trace("StateMachine.enterNextState: " + this.nextState);
		this.activeState.Exit();
		if (this.activeState == undefined || this.activeState.ExitFinished()) {
			this.activeState = this.states[this.nextState]
			this.activeState.Enter()
			this.nextState = "";
			trace("After switching nextState is : " +this.nextState);
		}
	}



	public function onEnterFrame() {
		trace("StateMachine.onEnterFrame, nextState: " + this.nextState)
		if (this.nextState != "") {
			this.enterNextState();
		} else {
			this.activeState.onEnterFrame()
		}
	}
}
