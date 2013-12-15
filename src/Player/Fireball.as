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
var vIsExploded = false;

var vLight;
var vTimer = 0;


/* "public" functions   */

/* SETUP */
if (vNumber > 0) {
	this.setupDirection(FireballSpeed) // Utilities.as

	this._x = this.vPlayer.getXPosition() + FireballXOffset;
	this._y = this.vPlayer.getYPosition() + FireballYOffset;

	// Set Direction to the same the player is facing
	gotoAndStop(this.vPlayer.getDirection());
}


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
	if (!vLight && this.vNumber > 0) {
		duplicateMovieClip(this.vOriginalFireballLight, this.vFireballLightName, this.vNumber);
		vLight = _root.world.darkness[vFireballLightName];

	}

	if (!this.vIsExploding) {
		
		if (hittest()) {
			this.vIsExploding = true;
		}	
		
		this._x += this.vKugelSpeedX;
		this._y += this.vKugelSpeedY;

		var enemiesHit = _root.enemiesHit(this)
		for (var i = 0; i < enemiesHit.length; i++  ) {
			enemy = enemiesHit[i];
			enemy._xscale-=20;
			_root.vPoints += 50;
		}
	} else if (!this.vIsExploded) {
		gotoAndStop("explode");
		this.vLight.explode();
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = 0;
		this.vIsExploded = true;
	}
	this.swapDepths(int(this._y));
	vTimer += 1;
	if (vTimer == 50) {
		this.removeMovieClip();
	}
}
