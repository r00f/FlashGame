onClipEvent (load) {

	#include "src/Utilities/Constants.as"

	var vBaby = _parent._parent._parent;
	var vDamage = vBaby.getDamage()
	var vAbsoluteKnockback = vBaby.getKnockback();
	;
}
onClipEvent (enterFrame) {
	var vKnockback;
	if (vBaby.getDirection() == Directions.left) {
		vKnockback = -vAbsoluteKnockback
	} else {
		vKnockback = vAbsoluteKnockback
	}
	if (_root.hitsPlayerBody(this)) {
		_root.world.player.knockback(vKnockback,0);
		_root.world.player.Hit(vDamage);
	}
}
