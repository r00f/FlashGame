
onClipEvent (load) {
	//vHit = 0;
damage = _parent._parent._parent._parent.damage
//trace("damage: " + damage)
knockback = -50
}
onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.hit_body)) {
		_root.world.player.knockback(-knockback,0);
		_root.world.playerhit(damage);
	}
}
