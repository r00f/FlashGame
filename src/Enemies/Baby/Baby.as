#include "src/Utilities/Constants.as"
moreaction = "";
dir = ""
action = "idle"
var HP = 100;

function getDirection() {
	return dir;
}


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
	

	if (x_now < (x_fix - horizontal_limit)) {
		xspeed = speed;
		dir = Directions.right;
		
	}
	
	if (x_now > (x_fix + horizontal_limit)) {
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
	x_now = int(this._x);
	y_now = int(this._y);

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
	if (xspeed != 0) {
		// Falls also eine Bewegung in x-Richtung ansteht:
		// Nächste x-Position mit derzeitiger Geschwindigkeit errechnen
		x_next = x_now+xspeed;
		// hitTest in x-Richtung
		// Falls dort auf eine Wand getroffen wird, die geplante Bewegung Stück für Stück reduzieren
		while (_parent.wall.hitTest((x_next), (y_now), true)) {
			if (xspeed>0) {
				// War man nach rechts unterwegs, muss nach links zurückgewichen werden...
				x_next = x_next-1;
			} else {
				// ...und umgekehrt.
				x_next = x_next+1;
			}
		}
		if (x_next == x_now) {
			// Falls die Wand bereits erreicht wurde, kann man nun noch prüfen, ob es sich um eine Schräge handelt.
			// Nun also grob nachschauen, ob nach oben hin ein Pixel frei ist:
			x_next = x_now+xspeed*0.25;
			y_next = y_now-speed*0.5;
			if (_parent.wall.hitTest((x_next), (y_next), true)) {
				// Ansonsten Nachschauen, ob nach unten hin ein Pixel frei ist:
				y_next = y_now+speed*0.5;
				if (_parent.wall.hitTest((x_next), (y_next), true)) {
					// Ist auch hier kein Pixel frei, bleibt die Spielfigur auf der Stelle stehen.
					x_next = x_now;
					y_next = y_now;
				}
			}
		}
	}
	// ---- Kollision in y-Richtung ----
	if (yspeed != 0) {
		// Falls also eine Bewegung in y-Richtung ansteht:
		// Nächste y-Position mit derzeitiger Geschwindigkeit errechnen
		y_next = y_now+yspeed;
		// hitTest in y-Richtung
		// Falls dort auf eine Wand getroffen wird, die geplante Bewegung Stück für Stück reduzieren
		while (_parent.wall.hitTest((x_now), (y_next), true)) {
			if (yspeed>0) {
				// War man nach unten unterwegs, muss nach oben zurückgewichen werden...
				y_next = y_next-1;
			} else {
				// ...und umgekehrt.
				y_next = y_next+1;
			}
		}
		if (y_next == y_now and xspeed == 0) {
			// Falls die Wand bereits erreicht wurde, kann man nun noch prüfen, ob es sich um eine Schräge handelt.
			// Nun also grob nachschauen, ob nach links hin ein Pixel frei ist:
			y_next = y_now+yspeed*0.25;
			x_next = x_now-speed*0.5;
			if (_parent.wall.hitTest((x_next), (y_next), true)) {
				// Ansonsten Nachschauen, ob nach rechts hin ein Pixel frei ist:
				x_next = x_now+speed*0.5;
				if (_parent.wall.hitTest((x_next), (y_next), true)) {
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
