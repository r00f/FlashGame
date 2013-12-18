onClipEvent (load) {

	#include "src/Utilities/Constants.as"

	var vBaby = _parent._parent._parent;
	damage = vBaby.getDamage()
	var vAbsoluteKnockback = vBaby.getKnockback();
	var vKnockback = vAbsoluteKnockback;
	trace("babydmg :" + damage);
	trace("babyknockback :" + vKnockback);
	trace("vBaby :" + vBaby);
}
onClipEvent (enterFrame) {
	if (vBaby.getDirection() == Directions.left) {
		vKnockback = -vAbsoluteKnockback
	} else {
		vKnockback = vAbsoluteKnockback
	}
	if (_root.hitsPlayerBody(this)) {
		_root.world.player.knockback(vKnockback,0);
		_root.world.player.Hit(damage);
	}
}
