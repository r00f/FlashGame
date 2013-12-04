import src.States.State;
class src.States.StateMachine {
	private var states:Object;

	private var activeState:State; 
	private var nextState:String;

	public function RegisterState(name:String, state:State) {
		this.states[name] = state;
	}

	public function EnterState(name) {
		if (this.states[name] != undefined) {
			this.nextState = name;

		}
	}

	private function enterNextState() {
		this.activeState.Exit();
		if (this.activeState.ExitFinished()) {
			this.activeState = this.states[this.nextState]
			this.activeState.Enter()
			this.nextState = "";
		}
	}



	public function onEnterFrame() {
		if (nextState != "") {
			this.enterNextState();
		} else {
			this.activeState.onEnterFrame()
		}
	}
}
