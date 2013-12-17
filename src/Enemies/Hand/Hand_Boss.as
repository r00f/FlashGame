#include "src/Utilities/Health.as"
#include "src/Utilities/Resourcebar.as"

_root.addEnemy(this);

var vAction;
var vHit = false;
var vHealthRegeneration:Number = 0;
this.vMaxHealth = 300;
this.vHealthPoints =  vMaxHealth,
var vResourceBarLinkage = "hp_bar_boss";
var vHealthBar = _root.interf.attachMovie(vResourceBarLinkage, vResourceBarLinkage, _root.interf.getNextHighestDepth());

vHealthBar._xscale = 4.0;
vHealthBar._yscale = 2.5;

this.onEnterFrame = function()
{
	this.swapDepths(int(this._y));

	if (this.getHealthPoints() <= 0) {
		this.vAction = "death";
	}
	animations.gotoAndStop(this.vAction);
	updateResourceBar(this.vHealthBar, this.getHealthPercentage());
}




