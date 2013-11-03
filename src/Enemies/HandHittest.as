onClipEvent (load) {
	//vHit = 0;
}
function hittest(x,y, root) {
	if (this.hitTest(root.t.world.player.hit_body)) {
		root.world.player.x_next -= x;
		root.world.player.y_next -= y;
		root.world.player.HP -= 20;
	}
}
