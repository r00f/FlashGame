#include "src/Utilities/Constants.as"
stop();

//_root.vNospelllight += 1;
vLight = "";
xKugelspeed = _root.xKugelspeed;
yKugelspeed = _root.yKugelspeed;
vTimer = 0;
vNumber = _root.vNokugel
player = _root.world.player;
//vLightNumber = _root.vNospelllight;

if (player.getDirection() == Directions.right)
{
	gotoAndStop(Directions.right);
}

if (player.getDirection() == Directions.left)
{
	gotoAndStop(Directions.left);
}

if (player.getDirection() == Directions.up)
{
	gotoAndStop(Directions.up);

}
if (player.getDirection() == Directions.down)
{
	gotoAndStop(Directions.down);
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
		vLight._x =   player._x;
		vLight._y =  (player._y)-25;
	}
	
	if (hittest()) {
		//vLight.removeMovieClip()
		gotoAndStop("explode");
		vLight.gotoAndPlay("explode");
		//_root.world.darkness.fireball_light.gotoAndPlay("explode");
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

		
	this.swapDepths(int(this._y));
	

	}
	
}

