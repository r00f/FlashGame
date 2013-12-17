onClipEvent (load) {
	//vHit = 0;
}

onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.body_hit)) {
		_root.world.player.knockback(0,-20);
		_root.world.player.Hit(20);
	}
}
