import src.States.State;
import src.Utilities.Coordinate;
import src.Enemies.Baby.BabyClass;
import src.Utilities.Directions;

class  src.States.Baby.WalkingState implements State {

	private var baby:BabyClass;
	private var baseSpeed:Number;
	private var xSpeed:Number;
	private var ySpeed:Number;

	private var actionName:String = "baby_walk";
	
	private var currentDirection:String;

	private var fixCoordinate:Coordinate;

	private var horizontalLimit = 100;
	private var verticalLimit = 50;


	private var nextPosition:Coordinate;

	// Constructor, called when creating this State
	public function WalkingState(baby:BabyClass) {
		// Store the baby
		this.baby = baby;
	}

	// Called when this state is entered
	 public function Enter():Void {
	 	// Set basic needed variables for the state.
		this.baseSpeed = random(6)+2;
		this.xSpeed = this.baseSpeed;
		this.ySpeed = 0;
		this.currentDirection = baby.getDirection();
		this.baby.setDamage(1/this.xSpeed * 100);
		this.baby.setKnockback(50);
		this.fixCoordinate = this.baby.getCoordinates();
 	}

    public function Exit():Void {
    	// Nothing todo when exiting, baby can transition into a different state at any time during walking
    }

    public function onEnterFrame():Void {
    	// Caluclate the proper direction
    	this.calculateDirection();

    	// Set the speed based on the direction
    	this.setSpeed();

    	this.calculateNextPosition()

    	// Update all relevant variables in the BabyClass
		this.updateBaby()
    }

    public function ExitFinished():Boolean {
    	return true;
    }

    // Same code as before but with instance variables of the walking state.
    private function calculateDirection() {
    	var coords = this.baby.getCoordinates();
    	if (coords.x < this.fixCoordinate.x - this.horizontalLimit) {
			this.currentDirection = Directions.right;
		}   

		if (coords.x > (this.fixCoordinate.x + this.horizontalLimit)) {
			this.currentDirection =  Directions.left;
		}
		
		if (coords.y > (this.fixCoordinate.y + this.verticalLimit)) {
			this.currentDirection =  Directions.up;
		}
		
		if (coords.y < (this.fixCoordinate.y - this.verticalLimit)) {	
			this.currentDirection =  Directions.down;
		}
    }

    private function setSpeed() {
    	if (this.currentDirection == Directions.left) {
			this.xSpeed = -this.baseSpeed;
		} else if (this.currentDirection == Directions.right ) {
			this.xSpeed = this.baseSpeed;
		} else if (this.currentDirection == Directions.up ) {
			this.ySpeed = -this.baseSpeed;
		} else if (this.currentDirection == Directions.down ) {
			this.ySpeed = this.baseSpeed;
		}
    }

    private function calculateNextPosition() {
    	var coords = this.baby.getCoordinates()
    	// Just add the speed to the position, works for something as simple as the baby.
    	this.nextPosition = new Coordinate(coords.x + this.xSpeed, coords.y + this.ySpeed);
    }

    private function updateBaby() {
    	baby.setDirection(this.currentDirection);
		this.baby.setCoordinates(this.nextPosition);
		this.baby.setAnimation(this.actionName)
    }


}
