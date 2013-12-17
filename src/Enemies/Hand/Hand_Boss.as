
_root.addEnemy(this);
#include "src/Utilities/Health.as"
var vAction;
var vHit = false;
var vMaxHealth = 300;
var vHealthRegeneration:Number = 0;
var vHealthPoints =  300;

this.onEnterFrame = function()
{
	this.swapDepths(int(this._y));
	
	if (this.getHealthPoints() <= 0) {
		this.vAction = "death";
	}
	animations.gotoAndStop(this.vAction);

}



