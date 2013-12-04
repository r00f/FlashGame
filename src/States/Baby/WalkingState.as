import src.States.State;
import src.Utilities.Coordinate;
import src.Enemies.Baby.BabyClass;
import src.Utilities.Directions;

class  src.States.Baby.WalkingState implements State {

	private var baby:BabyClass;
	private var baseSpeed:Number;
	private var xSpeed:Number;
	private var ySpeed:Number;

	private var actionName:String = "baby_walk_";



	private var currentDirection:String = Directions.left

	private var fixCoordinate:Coordinate;

	private var horizontalLimit = 100;
	private var verticalLimit = 50;


	public function WalkingState(baby:BabyClass) {
		this.baby = baby;
	}

	 public function Enter():Void {
	 	trace("Walking Enter");
		this.baseSpeed = random(6)+2;
		this.xSpeed = this.baseSpeed;
		this.ySpeed = 0;
		this.baby.setDamage(1/this.xSpeed * 100);
		this.baby.setKnockback(50);
		this.fixCoordinate = this.baby.getCoordinates();

	 	}
    public function Exit():Void {
    	trace("Walking Exit");

    }
    public function onEnterFrame():Void {
    	trace("Walking");
    	var coords = this.baby.getCoordinates()
    	var vXSpeed = 0;
    	var vYSpeed = 0;
    	if (coords.x < (this.fixCoordinate.x - this.horizontalLimit)) {
			vXSpeed = this.xSpeed;
			this.currentDirection = Directions.right;
		}
		if (coords.x > (this.fixCoordinate.x + this.horizontalLimit)) {

			vXSpeed = -this.xSpeed;
			this.currentDirection =  Directions.left;
		}
		
		if (coords.y > (this.fixCoordinate.y + this.verticalLimit)) {
			vYSpeed = -this.ySpeed;
			this.currentDirection =  Directions.up;
		}
		
		if (coords.y < (this.fixCoordinate.y - this.verticalLimit)) {
			vYSpeed = this.ySpeed;
			this.currentDirection =  Directions.down;
		}
		//calculateNextPosition(vXSpeed, vYSpeed) // Movement.as

		this.baby.setCoordinates(new Coordinate(coords.x+vXSpeed, coords.y + vYSpeed));


		this.baby.setAnimation(this.actionName+this.currentDirection)

    }

    public function ExitFinished():Boolean {
    	return true;
    }
}
