#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
stop();

this.blendMode = "alpha"
// "private" variables
var vIsExploding:Boolean = false;

var vIsExploded = false;

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
}
