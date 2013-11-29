#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
stop();

this.blendMode = "alpha"
// "private" variables
var vPlayer:MovieClip = _root.world.player;
var vKugelSpeedX:Number = 0;
var vKugelSpeedY:Number = 0;
var vIsExploding:Boolean = false;
this._x = this.vPlayer.getXPosition() + FireballXOffset;
this._y = this.vPlayer.getYPosition() + FireballYOffset;

vTimerkugel = 0;


gotoAndStop("explode");
this.setupDirection(FireballSpeed)

// "public" functions

function explode() {
	this.vIsExploding = true;
}


this.onEnterFrame = function() {
	if (!this.vIsExploding) {
		this._x += vKugelSpeedX;
		this._y += vKugelSpeedY;
	} else {
		gotoAndStop("explode");
	}
	vTimerkugel += 1;
	if (vTimerkugel == 50) {
		this.removeMovieClip();
	}
}

function setupDirection(speed:Number) {
	var playerDirection = this.vPlayer.getDirection();
	if (playerDirection == Directions.right) {
		this.vKugelSpeedX = speed;
		this.vKugelSpeedY = 0;
	} 

	if (playerDirection == Directions.left) {
		this.vKugelSpeedX = -speed;
		this.vKugelSpeedY = 0;
	}

	if (playerDirection == Directions.up) {
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = -speed;
	} 

	if (playerDirection == Directions.down) {
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = speed;
	}
}
