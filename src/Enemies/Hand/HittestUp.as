onClipEvent (load) {
	//vHit = 0;
}

onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.hit_body)) {
		_root.world.player.y_next -= 20;
		_root.world.player.HP -= 20;
	}
}
