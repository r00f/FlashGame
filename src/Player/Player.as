var sword = true
var weapon = "";
var dir = "right_";
var action = "";
var HP = 100;
var mana = 100;
var vTimerkugel = 0;
var manaBar = _root.interf.mana_bar
var healthBar = _root.interf.HP_bar

//wall sichtbar/nicht sichtbar
_parent.wall._visible = 0;

// Normgeschwindigkeit
var speed = 4;
// Kamerapositionswerte deklarieren
var cam_x = int(_parent._x);
var cam_y = int(_parent._y);
// In jedem Bild wiederkehrend ausgeführter Scriptteil:
this.onEnterFrame = function()
{

	// Nun die x- und y-Geschwindigkeiten der Spielfigur zurücksetzen
	var xspeed = 0;
	var yspeed = 0;
	

	// Dann diese Geschwindigkeiten anhand von Tastenbefehlen neu setzen
	if (_root.key_left == 1)
	{
		xspeed = -speed;
		dir = "left_";

	}
	if (_root.key_right == 1)
	{
		xspeed = speed;
		dir = "right_";
	}
	if (_root.key_up == 1)
	{
		yspeed = -speed;
		dir = "up_";
	}
	if (_root.key_down == 1)
	{
		yspeed = speed;
		dir = "down_";
	}
	

	if (_root.key_left == 0)
	{
		idle = 1;
	}
	if (_root.key_right == 0)
	{
		idle = 1;
	}
	if (_root.key_up == 0)
	{
		idle = 1;
	}
	if (_root.key_down == 0)
	{
		idle = 1;
	}
	
	
	if (_root.key_strg) {
		
		if ((vTimerkugel == 0) and (mana > 0)) {
			duplicateMovieClip(_root.world.kugel, "kugel"+_root.vNokugel, _root.vNokugel);
			_root.world["kugel"+_root.vNokugel]._x = _root.world.player._x;
			_root.world["kugel"+_root.vNokugel]._y = (_root.world.player._y)-25;
			_root.vNokugel += 1;
			mana -= 20;

			//action = "cast_"
			
			
			// den Kugelspeed auf plus- oder minuswert setzen
			
			
			if (dir == "right_") {
				_root.xKugelspeed = 10;
				_root.yKugelspeed = 0;
			} 
			
			if (dir == "left_") {
				_root.xKugelspeed = -10;
				_root.yKugelspeed = 0;
			}
			
			if (dir == "up_") {
				_root.yKugelspeed = -10;
				_root.xKugelspeed = 0;
			} 
			
			if (dir == "down_") {
				_root.yKugelspeed = 10;
				_root.xKugelspeed = 0;
			}
		}
		

	}
	// nur alle 10 frames abschuss der Kugel möglich
	vTimerkugel++;
	if (vTimerkugel == 10) {
		vTimerkugel = 0;
	}
	
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
	
	//this._x = next_coordinates.x;
	//this._y = next_coordinates.y;
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

	//trace(x_next);
	//trace(y_next);
	//trace(HP);
	//trace(mana);
	//trace(_root.key_space);
	//trace(dir);
	//trace(_root.vNospelllight);
	//trace(_root.vNolight);
	//trace(_root.vNokugel);
	
	if (_root.key_space == 1)
	{
		action = "hit_";
		idle = 0
	}
	
	if (idle)
	{
		action = "idle_";
	}
	if (_root.key_left or _root.key_right or _root.key_up or _root.key_down)
	{
		action = "walk_";
	}

	if (HP <= 0)
	{
		action = "death_";
	}
	
	if (sword = true)
	{
		weapon = "sword";
	}

	//animationsname definieren 
	anim = action + dir + weapon;
	animations.gotoAndStop(anim);

	this.swapDepths(int(this._y));

	moreaction = "";

	//HP-Balken
	updateResourceBar(healthBar, HP, 0);
	//mana-Balken
	updateResourceBar(manaBar, mana, 0.5);
	
	
};


function updateResourceBar(theBar:MovieClip, currentValue:Number, regen:Number) {
	if (currentValue== 100) {
		theBar.gotoAndStop("hundert");
	} else if (currentValue>= 90) {
		theBar.gotoAndStop("neun");
	} else if (currentValue>= 80) {
		theBar.gotoAndStop("acht");
	} else if (currentValue>= 70) {
		theBar.gotoAndStop("sieben");
	} else if (currentValue>= 60) {
		theBar.gotoAndStop("sechs");
	} else if (currentValue>= 50) {
		theBar.gotoAndStop("fuenf");
	} else if (currentValue>= 40) {
		theBar.gotoAndStop("vier");
	} else if (currentValue>= 30) {
		theBar.gotoAndStop("drei");
	} else if (currentValue>= 20) {
		theBar.gotoAndStop("zwei");
	} else if (currentValue>= 10) {
		theBar.gotoAndStop("eins");
	} else if (currentValue>= 0) {
		theBar.gotoAndStop("null");
	}
	if (currentValue < 100)  {
		currentValue += regen;
	}
}