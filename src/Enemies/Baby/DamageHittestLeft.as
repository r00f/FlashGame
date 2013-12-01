onClipEvent (load) {

	#include "src/Utilities/Constants.as"

	var vBaby = _parent._parent._parent._parent;
	damage = vBaby.getDamage()
	var vAbsoluteKnockback = vBaby.getKnockback()
	var vKnockback = vAbsoluteKnockback;
}
onClipEvent (enterFrame) {
	if (vBaby.getDirection() == Directions.left) {
		vKnockback = -vAbsoluteKnockback
	} else {
		vKnockback = vAbsoluteKnockback
	}
	if (this.hitTest(_root.world.player.hit_body)) {
		_root.world.player.knockback(vKnockback,0);
		_root.world.player.Hit(damage);
	}
}
