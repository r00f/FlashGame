stop();

this.blendMode = "alpha"
vTimerkugel = 0;
xKugelspeed = _root.xKugelspeed;
yKugelspeed = _root.yKugelspeed;

this.onEnterFrame = function()

{
	this._x += xKugelspeed;
	this._y += yKugelspeed;
			

	// nach 20 frames verschwindet die Kugel
	vTimerkugel += 1;
	if (vTimerkugel == 50) {
		this.removeMovieClip();
	}
	
}