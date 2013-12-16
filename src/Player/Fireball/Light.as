#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
stop();

this.blendMode = "alpha"
// "private" variables
var vPlayer:MovieClip = _root.world.player;
var vIsExploding:Boolean = false;

var vIsExploded = false;


/*
this._x = this.vPlayer.getXPosition() + FireballXOffset;
this._y = this.vPlayer.getYPosition() + FireballYOffset;

vTimerkugel = 0;
this.setupDirection(FireballSpeed) // Utilities.as
*/
// "public" functions

function explode() {
	this.vIsExploding = true;
}


this.onEnterFrame = function() {
	if (!this.vIsExploding) {
		this._x += this.vKugelSpeedX;
		this._y += this.vKugelSpeedY;
	} else if (!this.vIsExploded){
		this.vKugelSpeedY = 0;
		this.vKugelSpeedX = 0;
		gotoAndPlay("explode");
		
		this.vIsExploded = true;
	}
	vTimerkugel += 1;
	if (vTimerkugel == 50) {
		this.removeMovieClip();
	}
}
