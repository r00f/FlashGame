player = this._root.world.player

inFrontOfPlayer = false
this.onEnterFrame = function() {
	if ( (player._y-player._h/2-2) > (this._y) ){
	
		if (player.getDepth() <  this.getDepth()) {
			this.swapDepths(player)
		}
	} else {
		if (player.getDepth() >= this.getDepth()) {
			this.swapDepths(player)
		}
	}
}

/* Alternate version
this.onEnterFrame = function() {
	
 this.swapDepths(int(this._y));

}
*/