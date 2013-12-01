onClipEvent (load) {
	//vHit = 0;
}
onClipEvent (enterFrame) {
	if (this.hitTest(_root.world.player.hit) and _root.key_space == 1) {
		_root.world.door_01.door.gotoAndPlay("door_open")
		_root.world.wall.door_col_01.gotoAndStop("open")

		
	}
}