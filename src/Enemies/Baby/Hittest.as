onClipEvent (load) {
	//vHit = 0;
}
onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.hit_body)) {
		_parent._parent.moreaction = "hit"; 
	}
}
