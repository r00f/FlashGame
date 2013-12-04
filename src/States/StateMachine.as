import src.States.State;
class src.States.StateMachine {
	private var states:Object = new Object();

	private var activeState:State; 
	private var nextState:String;

	public function RegisterState(name:String, state:State) {
		 ("Registered State:" + name + ": " + state);
		this.states[name] = state;
	}

	public function EnterState(name) {

		if (this.states[name] != undefined) {
			this.nextState = name;
		} else {

		}
	}

	private function enterNextState() {

		this.activeState.Exit();
		if (this.activeState == undefined || this.activeState.ExitFinished()) {
			this.activeState = this.states[this.nextState]
			this.activeState.Enter()
			this.nextState = "";

		}
	}



	public function onEnterFrame() {

		if (this.nextState != "") {
			this.enterNextState();
		} else {
			this.activeState.onEnterFrame()
		}
	}
}
