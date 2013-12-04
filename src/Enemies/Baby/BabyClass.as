import src.States.StateMachine;
import src.States.Baby.WaitingState
import src.States.Baby.WalkingState
import src.States.Baby.AttackingState
import src.Utilities.Coordinate;
import src.Utilities.Directions;



class src.Enemies.Baby.BabyClass extends StateMachine {
	private var baby:MovieClip;

	private var wait:String = "Wait";
	private var walk:String = "Walk"
	private var attack:String = "Attack"
	private var waitWhile:Number;
	private var damage:Number;
	private var knockback:Number;
	private var currentAnimationName:String;
	private var currentDirection:String;

	public function BabyClass(baby) {

		this.baby = baby;
		this.waitWhile = random(24);

		// Register all the States
		this.RegisterState(this.wait, new WaitingState(this));
		this.RegisterState(this.walk, new WalkingState(this));
		this.RegisterState(this.attack, new AttackingState(this));

		// Start by waiting
		this.EnterState(wait);
	}


	public function onEnterFrame() {
		this.baby.swapDepths(int(this.baby._y));

		animate();

		if (this.waitWhile == 0) {
			this.waitWhile--;
			// If we stopped waiting start walking
			this.EnterState(walk);
		} else if (this.waitWhile > 0) {
			this.waitWhile--
		}
		// Always call super.onEnterFrame() to trigger the state machine.
		super.onEnterFrame()
	}


	public function doAttack() {
		this.EnterState(attack)
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
