
onClipEvent (load) {
	//vHit = 0;
damage = _parent._parent._parent._parent.damage
//trace("damage: " + damage)
knockback = -50
}
onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.hit_body)) {
		_root.world.player.x_next += knockback;
		_root.world.player.HP -= damage;
	}
}
