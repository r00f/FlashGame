#include "src/Utilities/Constants.as"
#include "src/Utilities/Utilities.as"

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
var vSword:Boolean = true
var vWeapon:String = "";
var vAction:String = "";
var vCurrentDirection:String = Directions.right;
var idle = 1;


/* Health / Mana */
var vMaxMana = 100;
var vMaxHealth = 100;
var vManaBar:MovieClip = _root.interf.mana_bar
var vHealthBar:MovieClip = _root.interf.HP_bar
var vHealthRegeneration:Number = 0;
var vManaRegeneration:Number = 0.5;

/* Fireball */
var vTimerkugel = 0;
var vFireBallManaCost = 20;
var vFireBallWaitFrames = 10;
var vFireBallOriginal:MovieClip = _root.world.kugel
var vFireBallName = "kugel"

var xnext = 0;
var ynext = 0;

var vManaPoints =  100;
var vHealthPoints =  100;


var kugelSpeed = {x: 0, y: 0}

//wall sichtbar/nicht sichtbar
_parent.wall._visible = 0;

// Normgeschwindigkeit
var speed = 4;
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

function getHealthPoints() {
	return this.vHealthPoints;
}

function getHealthPercentage() {
	return 1.0/this.vMaxHealth * this.vHealthPoints;
}

function getManaPoints() {
	return this.vManaPoints;
}
function getManaPercentage() {
	return 1.0/this.vMaxMana * this.vManaPoints;
}

function spendMana(points:Number) {
	this.changeMana(-points);
}

function Hit(damage:Number) {
	this.changeHealth(-damage);
}

function knockback(xDistance:Number, yDistance:Number) {
	x_next += xDistance;
	y_next += yDistance;
}


// Helper Functions

function changeMana(change) {
	this.vManaPoints += change;
}

function changeHealth(change) {
	this.vHealthPoints += change;	
}


this.onEnterFrame = function()
{
	handleFireball();

	move();
	
	animate();
	
	this.swapDepths(int(this._y));

	updateResourceBar(this.vHealthBar, this.getHealthPercentage());

	updateResourceBar(this.vManaBar, this.getManaPercentage());
	
	this.regenerate()
	
}

function regenerate() {
	if (this.getManaPoints() < this.vMaxMana) {
		this.changeMana(vManaRegeneration);
		this.changeHealth(vHealthRegeneration);
	}
}


function handleFireball() {
	if (_root.key_strg) {
		this.shootFireBallIfPossible()
	}
	// nur alle 10 frames abschuss der Kugel möglich
	vTimerkugel++;
}

function shootFireBallIfPossible() {
	if ((vTimerkugel > vFireBallWaitFrames) and (this.getManaPoints() >= vFireBallManaCost)) {
		var nextKugelNumber = _root.vNokugel++; // var a = b++ bedeutet a = b; b += 1;
		var nextFireBallName = vFireBallName + nextKugelNumber;
		duplicateMovieClip(vFireBallOriginal, nextFireBallName, nextKugelNumber);
		this.spendMana(vFireBallManaCost);
		vTimerkugel = 0;	
	}
}

function animate() {
	if (_root.key_space == 1) {
		this.vAction = "hit";
		this.idle = 0
	}
	if (this.idle) {
		this.vAction = "idle";
	}
	if (_root.key_left or _root.key_right or _root.key_up or _root.key_down) {
		this.vAction = "walk";
	}
	if (this.getHealthPoints() <= 0) {
		this.vAction = "death";
	}
	if (this.vSword = true) {
		this.vWeapon = "sword";
	}

	//animationsname definieren 
	var anim = this.vAction + "_" + this.vCurrentDirection + "_" + this.vWeapon;
	animations.gotoAndStop(anim);
}


function updateResourceBar(theBar:MovieClip, percent:Number) {
	if (percent >= 0.999) {
		theBar.gotoAndStop("hundert");
	} else if (percent >= 0.9) {
		theBar.gotoAndStop("neun");
	} else if (percent >= 0.8) {
		theBar.gotoAndStop("acht");
	} else if (percent >= 0.7) {
		theBar.gotoAndStop("sieben");
	} else if (percent >= 0.6) {
		theBar.gotoAndStop("sechs");
	} else if (percent >= 0.5) {
		theBar.gotoAndStop("fuenf");
	} else if (percent >= 0.4) {
		theBar.gotoAndStop("vier");
	} else if (percent >= 0.3) {
		theBar.gotoAndStop("drei");
	} else if (percent >= 0.2) {
		theBar.gotoAndStop("zwei");
	} else if (percent >= 0.1) {
		theBar.gotoAndStop("eins");
	} else if (percent >= 0) {
		theBar.gotoAndStop("null");
	}
}


/* Moving */

function calculateNewSpeed() {
	var newSpeed = {
		x: 0,
		y: 0
	};

	function adjustNewSpeedForDirection(direction, speed_change) {
		if (_root["key_"+direction] == 1) {
			 // _root["key_left"] ist das Gleiche wie _root.key_left
			vCurrentDirection = direction;
			if (speed_change.x) {
				// Die Funktion ist innerhalb von calculateNewSpeed und nach der Definition von newSpeed definiert, darum kann man von hier auf newSpeed zugreifen
				newSpeed.x = speed_change.x;
			}
			if (speed_change.y) {
				newSpeed.y = speed_change.y;
			}
		} else {
			this.idle = 1;
		}
	}
	
	// Mapping von richtung zu geschwindigkeit (left => x = -speed, usw)
	adjustNewSpeedForDirection(Directions.left, {x: -speed});
	adjustNewSpeedForDirection(Directions.right, {x: speed});
	adjustNewSpeedForDirection(Directions.up, {y: -speed});
	adjustNewSpeedForDirection(Directions.down, {y: speed});
	return newSpeed;
}

function move() {
	var xspeed = 0;
	var yspeed = 0;

	var newSpeed = calculateNewSpeed();
	xspeed = newSpeed.x;
	yspeed = newSpeed.y;
	// Bevor die Kollisionsabfrage loslegt, sollte man sich zunächst die aktuelle Position merken: 
	var x_now = int(this._x);
	var y_now = int(this._y);
	// ---- Kollision in x-Richtung ----
	// Da die hitTest-Funktion stets im Koordinatensystem der Hauptzeitleiste (Bühne) arbeitet,
	// muss das Koordinatensystem der Spielwelt vorübergehend deckungsgleich mit dem der Bühne 
	// gemacht werden:
	_parent._x = 0;
	_parent._y = 0;
	// Solche temporären Verschiebungen werden allerdings für die hitTest-Abfrage nur dann wirksam,
	// wenn durch eine Änderung der _quality-Eigenschaft ein Neuzeichnen der internen hitTest-Maske 
	// erfolgt.
	// Das trifft sich: Denn die hitTest-Methode arbeitet sowieso wesentlich exakter beim Rendern 
	// mit Kantenglättung. Daher können wir nun zwei Fliegen mit einer Klappe schlagen und auch
	// die Qualität temporär auf "high" setzen. Diese Einstellung wird (wie die Verschiebung nach 0/0)
	// am Ende der Schleife wieder zurückgenommen:
	
	_quality = "high";
	if (xspeed != 0)
	{
		// Falls also eine Bewegung in x-Richtung ansteht:
		// Nächste x-Position mit derzeitiger Geschwindigkeit errechnen
		x_next = x_now + xspeed;
		// hitTest in x-Richtung
		// Falls dort auf eine Wand getroffen wird, die geplante Bewegung Stück für Stück reduzieren
		while (_parent.wall.hitTest((x_next), (y_now), true))
		{
			if (xspeed > 0)
			{
				// War man nach rechts unterwegs, muss nach links zurückgewichen werden...
				x_next = x_next - 1;
			}
			else
			{
				// ...und umgekehrt.
				x_next = x_next + 1;
			}
		}
		if (x_next == x_now)
		{
			// Falls die Wand bereits erreicht wurde, kann man nun noch prüfen, ob es sich um eine Schräge handelt.
			// Nun also grob nachschauen, ob nach oben hin ein Pixel frei ist:
			x_next = x_now + xspeed * 0.25;
			y_next = y_now - speed * 0.5;
			if (_parent.wall.hitTest((x_next), (y_next), true))
			{
				// Ansonsten Nachschauen, ob nach unten hin ein Pixel frei ist:
				y_next = y_now + speed * 0.5;
				if (_parent.wall.hitTest((x_next), (y_next), true))
				{
					// Ist auch hier kein Pixel frei, bleibt die Spielfigur auf der Stelle stehen.
					x_next = x_now;
					y_next = y_now;
				}
			}
		}
	}
	// ---- Kollision in y-Richtung ---- 
	if (yspeed != 0)
	{
		// Falls also eine Bewegung in y-Richtung ansteht:
		// Nächste y-Position mit derzeitiger Geschwindigkeit errechnen
		y_next = y_now + yspeed;
		// hitTest in y-Richtung
		// Falls dort auf eine Wand getroffen wird, die geplante Bewegung Stück für Stück reduzieren
		while (_parent.wall.hitTest((x_now), (y_next), true))
		{
			if (yspeed > 0)
			{
				// War man nach unten unterwegs, muss nach oben zurückgewichen werden...
				y_next = y_next - 1;
			}
			else
			{
				// ...und umgekehrt.
				y_next = y_next + 1;
			}
		}
		if (y_next == y_now and xspeed == 0)
		{
			// Falls die Wand bereits erreicht wurde, kann man nun noch prüfen, ob es sich um eine Schräge handelt.
			// Nun also grob nachschauen, ob nach links hin ein Pixel frei ist:
			y_next = y_now + yspeed * 0.25;
			x_next = x_now - speed * 0.5;
			if (_parent.wall.hitTest((x_next), (y_next), true))
			{
				// Ansonsten Nachschauen, ob nach rechts hin ein Pixel frei ist:
				x_next = x_now + speed * 0.5;
				if (_parent.wall.hitTest((x_next), (y_next), true))
				{
					// Ist auch hier kein Pixel frei, bleibt die Spielfigur auf der Stelle stehen.
					x_next = x_now;
					y_next = y_now;
				}
			}
		}
	}
	
	
	// Nun, da sämtliche hitTest-Abfragen getätigt wurden, kann das Bild wieder ohne Kantenglättung gerendert werden 
	//_quality = "low";
	// Bewegung umsetzen
	this._x = x_next;
	this._y = y_next;
	
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
	_parent._x = int(cam_x);
	_parent._y = int(cam_y);
}
