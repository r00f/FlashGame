onClipEvent (load) {
	//vHit = 0;
}

onClipEvent (enterFrame) {
	if (_root.hitsPlayerBody(this)) {
		_root.world.player.knockback(0,20);
		_root.world.player.Hit(20);
	}
}
