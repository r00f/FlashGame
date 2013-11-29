stop();

//_root.vNospelllight += 1;
vLight = "";
xKugelspeed = _root.xKugelspeed;
yKugelspeed = _root.yKugelspeed;
vTimer = 0;
vNumber = _root.vNokugel
//vLightNumber = _root.vNospelllight;


	if (_root.world.player.dir == "right_")
	{
		gotoAndStop("right");

	}
	
	if (_root.world.player.dir == "left_")
	{
		gotoAndStop("left");

	}
	
		if (_root.world.player.dir == "up_")
	{
		gotoAndStop("up");


	}
	
		if (_root.world.player.dir == "down_")
	{
		gotoAndStop("down");


	}

function hittest() {
	for (var i = 0; i < _root.vWalls.length; i++) {
		var wall = _root.vWalls[i];
		if (fireball_hit.hitTest(wall)) {
		 	return true;
	 	}
	}
	return false;
}

this.onEnterFrame = function()
{
	if (vLight == "") {
		duplicateMovieClip(_root.world.darkness.fireball_light, "fireball_light"+vNumber, vNumber);
		vLight = _root.world.darkness["fireball_light"+vNumber];
		vLight._x =   _root.world.player._x;
		vLight._y =  (_root.world.player._y)-25;
	}
	
	if (hittest()) {
		vLight.removeMovieClip()
		gotoAndStop("explode");
		xKugelspeed = 0;
		yKugelspeed = 0;
	}	
	
	this._x += xKugelspeed;
	this._y += yKugelspeed;
	
	for (i=1; i<=10; i++) {
		if (this.hitTest(_parent["gegner"+i])) {
			_parent["gegner"+i]._xscale-=20;
			_root.vPoints += 50;
		}
			

	// nach 20 frames verschwindet die Kugel
	vTimer += 1;
	if (vTimer == 50) {
		this.removeMovieClip();
	}
	
	
	//_root.world.darkness["fireball_light"+_root.vNospelllight]._x =  _root.world.player._x;
	//_root.world.darkness["fireball_light"+_root.vNospelllight]._y = (_root.world.player._y)-25;
	

		
	this.swapDepths(int(this._y));
	

	}
	
}

