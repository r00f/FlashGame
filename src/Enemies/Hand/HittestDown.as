onClipEvent (load) {
	//vHit = 0;
}

onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.hit_body)) {
		_root.world.player.applyKnockback(0,20);
		_root.world.player.hit(20);
	}
}
