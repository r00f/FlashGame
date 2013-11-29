#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
stop();

this.blendMode = "alpha"
// "private" variables
var vPlayer = _root.world.player;
var vKugelSpeedX:Number = 0;
var vKugelSpeedY:Number = 0;
var vIsExploding = false;
this._x = this.vPlayer.getXPosition() + FireballXOffset;
this._y = this.vPlayer.getYPosition() + FireballYOffset;

vTimerkugel = 0;

this.setupDirection(FireballSpeed)

// "public" functions

function explode() {
	this.vIsExploding = true;
}


this.onEnterFrame = function() {
	if (!this.vIsExploding) {
		this._x += vKugelSpeedX;
		this._y += vKugelSpeedY;
	}
	vTimerkugel += 1;
	if (vTimerkugel == 50) {
		this.removeMovieClip();
	}
}