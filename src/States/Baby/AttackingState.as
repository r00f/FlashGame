import src.States.State;
import src.Enemies.Baby.BabyClass;

class src.States.Baby.AttackingState implements State {

    private var baby:BabyClass;

    public function AttackingState(baby:BabyClass) {
        // Store the baby
        this.baby = baby;
    }

	 public function Enter():Void {
        // The animation does the rest.
        this.baby.setAnimation("hit");
 	}

    public function Exit():Void {
    }

    public function onEnterFrame():Void {

    }

    public function ExitFinished():Boolean {
        return true;
    }
}
