this.onEnterFrame = function()
{

	var enemiesHit = _root.enemiesHit(this)
	for (var i = 0; i < enemiesHit.length; i++  ) {
		enemy = enemiesHit[i];
		enemy._xscale-=20;
		_root.vPoints += 50;
	}

}
