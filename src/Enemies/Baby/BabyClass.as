import src.States.StateMachine;
import src.States.Baby.WaitingState
import src.States.Baby.WalkingState
import src.States.Baby.AttackingState
import src.Utilities.Coordinate;
import src.Utilities.Directions;

class src.Enemies.Baby.BabyClass {
	private var baby:MovieClip;

	// State Machine

	private var stateMachine:StateMachine;

	// State Names
	private var wait:String = "Wait";
	private var walk:String = "Walk"
	private var attack:String = "Attack"

	// needed variables to control the states
	private var waitWhile:Number;
	private var damage:Number;
	private var knockback:Number;
	private var currentAnimationName:String;
	private var currentDirection:String = Directions.right;

	public function BabyClass(baby) {
		this.stateMachine = new StateMachine(),
		this.baby = baby;
		this.waitWhile = random(24);

		// Register all the States
		this.stateMachine.RegisterState(this.wait, new WaitingState(this));
		this.stateMachine.RegisterState(this.walk, new WalkingState(this));
		this.stateMachine.RegisterState(this.attack, new AttackingState(this));

		// Start by waiting
		this.stateMachine.EnterState(wait);
	}


	public function onEnterFrame() {
		this.baby.swapDepths(int(this.baby._y));

		animate();

		if (this.waitWhile == 0) {
			this.waitWhile--;
			// If we stopped waiting start walking
			this.stateMachine.EnterState(walk);
		} else if (this.waitWhile > 0) {
			this.waitWhile--
		}
		// Always call super.onEnterFrame() to trigger the state machine.
		this.stateMachine.onEnterFrame()
	}


	public function doAttack() {
		this.stateMachine.EnterState(attack)
	}

	public function getDamage() {
		return this.damage;
	}

	public function setDamage(damage:Number) {
		this.damage = damage;
	}

	public function getDirection() {
		return this.currentDirection;
	}

	public function setDirection(newDirection:String) {
		this.currentDirection = newDirection;
	}

	public function getKnockback() {
		return this.knockback;
	}
	public function setKnockback(knockback:Number) {
		return this.knockback = knockback;
	}

	public function getCoordinates() {
		return new Coordinate(this.baby._x,this.baby._y)
	}

	public function setAnimation(name) {
		this.currentAnimationName = name;
	}


	public function setCoordinates(nextCoordinates) {

		this.baby._x = nextCoordinates.x;
		this.baby._y = nextCoordinates.y;
	}

	private function animate() {
		this.baby.animations.gotoAndStop(this.currentAnimationName + "_" +this.currentDirection);
	}
}
