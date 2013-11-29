#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
stop();


/*  "private" variables   */
var vPlayer:MovieClip = _root.world.player;
var vKugelSpeedX:Number = 0;
var vKugelSpeedY:Number = 0;

var vOriginalFireballLight:MovieClip = _root.world.darkness.fireball_light;
var vNumber = _root.vNokugel;
var vFireballLightName:String = "fireball_vLight" + vNumber;

var vLight;
var vTimer = 0;

/* "public" functions   */

/* SETUP */

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
	if (!vLight) {
		duplicateMovieClip(vOriginalFireballLight, vFireballLightName, vNumber);
		vLight = _root.world.darkness[vFireballLightName];
	}
	
	if (hittest()) {
		//vLight.removeMovieClip()
		gotoAndStop("explode");
		vLight.explode();
		vLight.gotoAndStop("explode");
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = 0;
	}	
	
	this._x += this.vKugelSpeedX;
	this._y += this.vKugelSpeedY;
	
	for (i=1; i<=10; i++) {
		if (this.hitTest(_parent["gegner"+i])) {
			_parent["gegner"+i]._xscale-=20;
			_root.vPoints += 50;
		}
			

	// nach 20 frames verschwindet die Kugel
	vTimer += 1;
	if (vTimer == 50) {
		this.removeMovieClip();
	}

		
	this.swapDepths(int(this._y));
	

	}
	
}

