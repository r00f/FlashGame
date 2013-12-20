
_root.addEnemy(this);
#include "src/Utilities/Health.as"
var vAction;
var vHit = false;

this.onEnterFrame = function()
{
	this.swapDepths(int(this._y));

	if (this.getHealthPoints() <= 0) {
		this.vAction = "death";
	}
	animations.gotoAndStop(this.vAction);
}



