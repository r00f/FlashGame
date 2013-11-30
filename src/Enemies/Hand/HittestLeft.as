onClipEvent (load) {
	//vHit = 0;
}

onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.hit_body)) {
		_root.world.player.knockback(-20,0);
		_root.world.player.hit(20);
	}
	
	
}
