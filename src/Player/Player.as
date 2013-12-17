#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"
#include "src/Utilities/Movement.as"
#include "src/Utilities/Health.as"
#include "src/Utilities/Mana.as"
#include "src/Utilities/Resourcebar.as"

/* Interface "Documentation"

 Player
 	- getDirection() : Returns String with the Direction

 	- getXPosition() : Returns the current X Coordinate
 	- getYPosition() : Returns the current Y Coordinate

 	- getHealthPoints() : Returns the Health Amount
 	- getHealthPercentage() : Returns % of Health Remaining between 0 and 1
 	- Hit(damage:Number) : Reduces the life by damage

 	- getManaPoints() : Returns the Mana Points
 	- getManaPercentage() : Returns % of Mana Remaining between 0 and 1
 	- spendMana(points:Number) : Spends points ManaPoints

 	- knockback(xDistance, yDistance) : Knocks the player back by xDistance and yDistance

*/

// "private" variables

/* Animation-Related Vars */
var vSword:Boolean = true;
var vWeapon:String = "";
var vAction:String = "";
var vCurrentDirection:String = Directions.right;
var idle = 1;


/* Health / Mana */
var vManaBar:MovieClip = _root.interf.mana_bar;
var vHealthBar:MovieClip = _root.interf.HP_bar;
this.vHealthRegeneration = 0;
this.vManaRegeneration = 0.5;

/* Fireball */
var vTimerkugel = 0;
var vFireBallManaCost = 25;
var vFireBallWaitFrames = 10;
var vFireBallOriginal = "fireball";
var vFireBallName = "kugel";

var x_next;
var y_next;

var vManaPoints =  100;
var vHealthPoints =  100;


var kugelSpeed = {x: 0, y: 0}

var vDead = "";

//wall sichtbar/nicht sichtbar
_parent.wall._visible = 0;

// Normgeschwindigkeit
var speed = 6;
// Kamerapositionswerte deklarieren
var cam_x = int(_parent._x);
var cam_y = int(_parent._y);


// "public" functions

function getDirection() {
	return vCurrentDirection;
}

function getXPosition() {
	return this._x;
}

function getYPosition() {
	return this._y;
}

function knockback(xDistance:Number, yDistance:Number) {
	x_next += xDistance;
	y_next += yDistance;
}

this.onEnterFrame = function()
{
	handleFireball();

	move();

	animate();

	updateResourceBar(this.vHealthBar, this.getHealthPercentage());

	updateResourceBar(this.vManaBar, this.getManaPercentage());

	this.regenerate()

	this.swapDepths(int(this._y));
}

function handleFireball() {
	if (_root.key_strg) {
		this.shootFireBallIfPossible();
	}
	vTimerkugel++;
}

function shootFireBallIfPossible() {
	if ((vTimerkugel > vFireBallWaitFrames) and (this.getManaPoints() >= vFireBallManaCost)) {
		// var a = b++ bedeutet var a = b; b += 1;
		var nextFireBallNumber = _root.vNokugel;
		var nextName = vFireBallOriginal + nextFireBallNumber;
		trace("NextFireballName: " + nextName)
		_root.world.attachMovie(vFireBallOriginal,nextName , nextFireBallNumber, {number: nextFireBallNumber });
		this.spendMana(vFireBallManaCost);
		vTimerkugel = 0;
		_root.vNokugel++;

	}
}

function move() {
	var newSpeed = calculateNewSpeed();
	calculateNextPosition(newSpeed.x,newSpeed.y); // Movement.as
	moveCamera();
}

function calculateNewSpeed() {
	var xSpeedMultiplier = 0;
	var ySpeedMultiplier = 0;

	if (isDirectionKeyPressed(Directions.left)) {
		xSpeedMultiplier = -1;
		this.vCurrentDirection = Directions.left;
	}
	if (isDirectionKeyPressed(Directions.right)) {
		xSpeedMultiplier = 1;
		this.vCurrentDirection = Directions.right;
	}
	if (isDirectionKeyPressed(Directions.up)) {
		ySpeedMultiplier = -1;
		this.vCurrentDirection = Directions.up;
	}
	if (isDirectionKeyPressed(Directions.down)) {
		ySpeedMultiplier = 1;
		this.vCurrentDirection = Directions.down;
	}
	if (xSpeedMultiplier != 0 and ySpeedMultiplier != 0) {
		ySpeedMultiplier /= Math.sqrt(2);
		xSpeedMultiplier /= Math.sqrt(2);
	}
	return {
		x: xSpeedMultiplier * speed,
		y: ySpeedMultiplier * speed
	};
}

function isDirectionKeyPressed(direction) {
	return _root["key_"+direction] == 1; //_root["key_left"] ist dasselbe wie _root.key_left
}

function moveCamera() {
	// "Kamera" mitbewegen - sprich: Umgebung gegenläufig zur Bewegung der Spielfigur bewegen
	// Weiches Scrolling:
	// Zuerst Zielposition für die Kamera ermitteln
	cam_x_aim = -this._x + 200;
	cam_y_aim = -this._y + 160;
	// Nun die Umgebung verzögert an diese Position annähern
	cam_x = cam_x + (cam_x_aim - cam_x) * 0.1;
	cam_y = cam_y + (cam_y_aim - cam_y) * 0.1;
	// Dabei sollte die Umgebung immer exakt im Pixelraster sitzen, daher hier nur ganze Zahlenwerte zulassen:
	// ( "int" scheidet einfach die Nachkommastellen ab )
	_root.world._x = int(cam_x);
	_root.world._y = int(cam_y);
}

function animate() {
	var animationName;
	if (this.vDead == "") {
		if (_root.key_space == 1) {
			this.vAction = "hit";
			this.idle = 0;
		} else {
			this.idle = 1;
		}
		if (this.idle) {
			this.vAction = "idle";
		}
		if (_root.key_left or _root.key_right or _root.key_up or _root.key_down) {
			this.vAction = "walk";
		}
		if (this.vSword = true) {
			this.vWeapon = "sword";
		}
		if (this.getHealthPoints() <= 0) {
			this.vAction = "death";
			speed = 0;
			vDead = this.animationName();
		}
		animationName = this.animationName();
	} else {
		animationName = this.vDead;
	}
	animations.gotoAndStop(animationName);
}

function animationName() {
	return  this.vAction + "_" + this.vCurrentDirection + "_" + this.vWeapon;
}

function regenerate() {
	this.regenerateMana();
	this.regenerateHealth();
}
