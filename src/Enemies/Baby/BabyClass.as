import src.States.StateMachine;
import src.States.Baby.WaitingState
import src.States.Baby.WalkingState
import src.Utilities.Coordinate;
import src.Utilities.Directions;



class src.Enemies.Baby.BabyClass extends StateMachine {
	private var baby:MovieClip;

	private var wait:String = "Wait";
	private var walk:String = "Walk"
	private var waitWhile:Number;
	private var damage:Number;
	private var knockback:Number;
	private var currentAnimationName:String;

	public function Baby(baby:MovieClip) {
		this.baby = baby;
		this.waitWhile = random(24);


		this.RegisterState(wait, new WaitingState(this));
		this.RegisterState(walk, new WalkingState(this));
		this.EnterState(wait);
	}


	public function onEnterFrame() {
		this.baby.swapDepths(int(this.baby._y));
		animate();
		if (this.waitWhile <= 0) {
			this.EnterState(walk);
		} else {
			this.waitWhile--
		}
		super.onEnterFrame()
	}


	public function doAttack() {
		//this.vHit = true;
	}

	public function getDamage() {
		return this.damage;
	}

	public function setDamage(damage:Number) {
		this.damage = damage;
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
		this.baby.animations.gotoAndStop(this.currentAnimationName);
	}
}
