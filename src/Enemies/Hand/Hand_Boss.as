#include "src/Utilities/Resourcebar.as"

var vResourceBarLinkage = "hp_bar_boss";
var vHealthBar = _root.interf.attachMovie(vResourceBarLinkage, vResourceBarLinkage, _root.interf.getNextHighestDepth());

vHealthBar._xscale = 150;
vHealthBar._yscale = 120;
vHealthBar._y -= 270
vHealthBar._x -= 50


this.onEnterFrame = function()
{
	updateResourceBar(this.vHealthBar, this._parent.getHealthPercentage());
}

