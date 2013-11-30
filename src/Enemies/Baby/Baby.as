#include "src/Utilities/Constants.as"
#include "src/Utilities/Movement.as"

moreaction = "";
dir = ""
action = "idle"
var HP = 100;

function getDirection() {
	return dir;
}

var x_next;
var y_next;

x_fix = int(this._x);
y_fix = int(this._y);

horizontal_limit = 100
vertical_limit = 50
// Normgeschwindigkeit
speed = random(6)+2;
xspeed = 6;

damage = 1/speed * 100

wait = random(24);
// In jedem Bild wiederkehrend ausgeführter Scriptteil:
this.onEnterFrame = function() {
	
// Nun die x- und y-Geschwindigkeiten der Spielfigur zurücksetzen
if (wait > 0) {
	wait = wait - 1;
	return;
}
yspeed = 0;	

	if (moreaction == "hit") {
		action = "hit_";
		xspeed = 0;
	}
	

	if (x_next < (x_fix - horizontal_limit)) {
		xspeed = speed;
		dir = Directions.right;
		
	}
	
	if (x_next > (x_fix + horizontal_limit)) {
		xspeed = -speed;
		dir =  Directions.left;
	}
	
	if (y_next > (y_fix + vertical_limit)) {
		yspeed = -speed;
		dir =  Directions.up;
	}
	
	if (y_next < (y_fix - vertical_limit)) {
		yspeed = speed;
		dir =  Directions.down;
	}
	
	// Bevor die Kollisionsabfrage loslegt, sollte man sich zunächst die aktuelle Position merken:
	calculateNextPosition(xspeed, yspeed)

	if (idle) {
		action = "idle_";
	}
	if (xspeed != 0 or yspeed !=0) {
		action = "baby_walk_";
	}


	
    //animationsname definieren
	anim = action+dir;
	
	animations.gotoAndStop(anim);
	
	
	moreaction = "";

	this.swapDepths(int(this._y));

};

