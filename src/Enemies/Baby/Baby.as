#include "src/Utilities/Constants.as"
#include "src/Utilities/Movement.as"

/* "Documentation" 
	
	Baby
		- doAttack() : Does the attack in the next frame
		- getDirection() : Returns the direction
		- getDamage() : Returns the damage
		- getKnockback() : Returns the knoback its attack does

*/

var vHit = false;
var vAction;

var vDirection = Directions.right;

var vSpeed = random(6)+2;
var vXSpeed = this.vSpeed;
var vYSpeed = 0;

var vDamage = 1/this.vSpeed * 100;
var vKnockback = 50;

function doAttack() {
	this.vHit = true;
}

function getDirection() {
	return this.vDirection;
}

function getDamage() {
	return this.vDamage;
}
function getKnockback() {
	return this.vKnockback;
}
var vFixPositionX = int(this._x);
var vFixPositionY  = int(this._y);

var vHorizontalLimit = 100;
var vVerticalLimit = 50;

var vWait = random(24);

var x_next;
var y_next;

// In jedem Bild wiederkehrend ausgeführter Scriptteil:
this.onEnterFrame = function() {
	
	if (vWait > 0) {
		vWait = vWait - 1;
		return;
	}
	
	
	if (this.vHit) {
		vXSpeed = 0;
		vYSpeed = 0;	
		this.vAction = "hit_";
	} else {


		if (this._x < (vFixPositionX - vHorizontalLimit)) {
			vXSpeed = this.vSpeed;
			this.vDirection = Directions.right;
		}
		if (this._x > (vFixPositionX + vHorizontalLimit)) {

			vXSpeed = -this.vSpeed;
			this.vDirection =  Directions.left;
		}
		
		if (this._y > (vFixPositionY + vVerticalLimit)) {
			vYSpeed = -this.vSpeed;
			this.vDirection =  Directions.up;
		}
		
		if (this._y < (vFixPositionY - vVerticalLimit)) {
			vYSpeed = this.vSpeed;
			this.vDirection =  Directions.down;
		}
		calculateNextPosition(vXSpeed, vYSpeed) // Movement.as

		if (vXSpeed != 0 or vYSpeed !=0) {
			this.vAction = "baby_walk_";
		}
	}

	animations.gotoAndStop(this.vAction+this.vDirection);
	this.swapDepths(int(this._y));
};

