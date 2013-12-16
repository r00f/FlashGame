var vTotalFrames = _parent._totalframes;
var vEnemiesHitWithCurrentHit = new Object();
var vCurrentFrame = 0;

this.onEnterFrame = function()
{
	if (this.vCurrentFrame >= this.vTotalFrames) {
		this.vCurrentFrame = 0;
		this.vEnemiesHitWithCurrentHit = new Object();
	}
	var enemiesHit = _root.enemiesHit(this)
	for (var i = 0; i < enemiesHit.length; i++  ) {
		enemy = enemiesHit[i];		
		if (!this.vEnemiesHitWithCurrentHit[enemy]) {
			this.vEnemiesHitWithCurrentHit[enemy] = true
			enemy.Hit(3);
		}
	}
	this.vCurrentFrame++;

}
