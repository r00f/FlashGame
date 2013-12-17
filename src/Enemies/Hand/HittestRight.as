onClipEvent (load) {
	//vHit = 0;
}

onClipEvent (enterFrame) {
	if (_root.hitsPlayerBody(this)) {
		_root.world.player.knockback(20,0);
		_root.world.player.Hit(20);
	}
}
