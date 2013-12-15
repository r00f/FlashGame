this.swapDepths(int(this._y));
_root.addEnemy(this);
#include "src/Utilities/Health.as"
var vAction;
var vHit = false;


this.onEnterFrame = function()
{
	if (this.getHealthPoints() <= 0) {
		this.vAction = "death";
}


	animations.gotoAndStop(this.vAction);
	
	}
		


