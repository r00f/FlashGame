#include "src/Utilities/Health.as"

this.swapDepths(int(this._y));
_root.addEnemy(this);

this.onEnterFrame = function()
{
	animate();

}


function animate() {

	if (this.getHealthPoints() <= 0) {
		this.vAction = "death";
	}

	var animationName = this.vAction;
	animations.gotoAndStop(animationName);
}


