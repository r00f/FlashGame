#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
stop();


/*  "private" variables   */
var vPlayer:MovieClip = _root.world.player;
var vKugelSpeedX:Number = 0;
var vKugelSpeedY:Number = 0;

var vOriginalFireballLight:MovieClip = _root.world.darkness.fireball_light;
var vNumber = _root.vNokugel;
var vFireballLightName:String = "fireball_light" + vNumber;

var vIsExploding = false;

var vLight;
var vTimer = 0;

/* "public" functions   */

/* SETUP */
trace("fireball created");
this.setupDirection(FireballSpeed)

this._x = this.vPlayer.getXPosition() + FireballXOffset;
this._y = this.vPlayer.getYPosition() + FireballYOffset;

// Set Direction to the same the player is facing

gotoAndStop(this.vPlayer.getDirection());



function hittest() {
	for (var i = 0; i < _root.vWalls.length; i++) {
		var wall = _root.vWalls[i];
		if (fireball_hit.hitTest(wall)) {
		 	return true;
	 	}
	}
	return false;
}

this.onEnterFrame = function()
{
	//trace("Fireball: " + this.vKugelSpeedX);
	trace("Fireball");
	trace("Light of Firebal: " + vLight);
	if (!vLight) {
		duplicateMovieClip(vOriginalFireballLight, vFireballLightName, vNumber);
		vLight = _root.world.darkness[vFireballLightName];

	}

	if (!this.vIsExploding) {
		
		if (hittest()) {
			this.vIsExploding = true;
		}	
		
		this._x += this.vKugelSpeedX;
		this._y += this.vKugelSpeedY;
		
		for (i=1; i<=10; i++) {
			if (this.hitTest(_parent["gegner"+i])) {
				_parent["gegner"+i]._xscale-=20;
				_root.vPoints += 50;
			}
		// nach 20 frames verschwindet die Kugel

	} else {
		gotoAndStop("explode");
		this.vLight.explode();
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = 0;
	}
	this.swapDepths(int(this._y));
	vTimer += 1;
	if (vTimer == 50) {
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
