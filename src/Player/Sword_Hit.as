this.onEnterFrame = function()
{

	var enemiesHit = _root.enemiesHit(this)
	for (var i = 0; i < enemiesHit.length; i++  ) {
		enemy = enemiesHit[i];
		enemy.Hit(1);
		_root.vPoints += 50;
	}

}
