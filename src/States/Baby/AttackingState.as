import src.States.State;
import src.Enemies.Baby.BabyClass;

class   src.States.Baby.AttackingState implements State {

    private var baby:BabyClass;


    public function AttackingState(baby:BabyClass) {
        this.baby = baby;
    }

	 public function Enter():Void {
	 	trace("Attacking Enter");
        this.baby.setAnimation("hit")

	 	}
    public function Exit():Void {
    	trace("Attacking Exit");

    }
    public function onEnterFrame():Void {
    	trace("Attacking");

    }

    public function ExitFinished():Boolean {
    	return true;
    }
}
