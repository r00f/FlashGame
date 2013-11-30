onClipEvent (load) {

	#include "src/Utilities/Constants.as"

	var vBaby = _parent._parent._parent._parent;
	//vHit = 0;
	damage = vBaby.damage
	//trace("damage: " + damage)
	var vAbsoluteKnockback = 50
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
