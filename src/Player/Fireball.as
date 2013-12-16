#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
stop();


/*  "private" variables   */
var vPlayer:MovieClip = _root.world.player;
var vKugelSpeedX:Number = 0;
var vKugelSpeedY:Number = 0;

var vOriginalFireballLight = "light_fireball";

var vIsExploding = false;
var vIsExploded = false;

var vLight;
var vTimer = 0;

trace("New Fireball: " + this + " number: " + this.number)

/* "public" functions   */

/* SETUP */
this.setupDirection(FireballSpeed) // Utilities.as

this._x = this.vPlayer.getXPosition() + FireballXOffset;
this._y = this.vPlayer.getYPosition() + FireballYOffset;
//vKugelSpeedX = 0;
//vKugelSpeedY = 0;
this.vLight = _root.world.darkness.attachMovie(vOriginalFireballLight, vOriginalFireballLight+this.number, this.number, 
	{ _x: this._x, _y: this._y });

// Set Direction to the same the player is facing
gotoAndStop(this.vPlayer.getDirection());



trace("Fireball: "+ this._x + ","+this._y)
trace("Light: " + this.vLight)
trace("Player: "+ vPlayer._x + ","+vPlayer._y)

this.onEnterFrame = function()
{
	if (!this.vIsExploding) {
		
		if (_root.hitAWall(this)) {
			this.vIsExploding = true;
		}	
		
		this._x += this.vKugelSpeedX;
		this._y += this.vKugelSpeedY;
		this.vLight._x += this.vKugelSpeedX;
		this.vLight._y += this.vKugelSpeedY;

		var enemiesHit = _root.enemiesHit(this)
		for (var i = 0; i < enemiesHit.length; i++  ) {
			enemy = enemiesHit[i];
			enemy.Hit(5);
			//enemy._xscale-=20;
			//_root.vPoints += 50;
		}
	} else if (!this.vIsExploded) {

		trace("Fireball explode: " +this)
		gotoAndStop("explode");
		this.vLight.gotoAndPlay("explode");
		this.vLight.explode();
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = 0;
		this.vIsExploded = true;
	}
	this.swapDepths(int(this._y));
	vTimer += 1;
	if (vTimer == 50) {
		this.vIsExploding = true;
	}
}
