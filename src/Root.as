_xscale=200;
_yscale=200;

var xKugelspeed = 0;
var yKugelspeed = 0;
var vNolight = 0;
var vNokugel =0;
var vQuality = "high"
var vMusic = 1;
_quality = vQuality;

this.onEnterFrame = function() {
	_root.key_left = Key.isDown(37) ? true : false;
	_root.key_up = Key.isDown(38) ? true : false;
	_root.key_right = Key.isDown(39) ? true : false;
	_root.key_down = Key.isDown(40) ? true : false;
	_root.key_strg = Key.isDown(17) ? true : false;
	_root.key_shift = Key.isDown(16) ? true : false;
	_root.key_space = Key.isDown(32) ? true : false;
	_root.key_esc = Key.isDown(27) ? true : false;
	_root.key_enter = Key.isDown(13) ? true : false;
	//trace(vMusic);
};

stop();
var vTest = 0;
var vEnemiesList = new Array();

function addEnemy(enemy) {
	vEnemiesList.push(enemy);
}

function removeEnemy(enemy) {
	for (var i = 0; i < vEnemiesList.length; i++ ) {
		if (vEnemiesList[i] == enemy) {
			if (i == vEnemiesList - 1) {
					vEnemiesList = vEnemiesList.slice(0,i)
				} else {
					vEnemiesList = vEnemiesList.slice(0,i).concat(vEnemiesList.slice(i+1))
			}
			
		}
	}
}

function enemiesHit(hitbox):Array {
	var returnArray = new Array();
	for (var i = 0; i < vEnemiesList.length; i++) {
		if (hitbox.hitTest(vEnemiesList[i].animations.body_hit)) {
			returnArray.push(vEnemiesList[i]);
		}
	}
	return returnArray;
}


function hitAWall(hitbox) {
	var x_now = int(this.world._x);
	var y_now = int(this.world._y);
	this.world._x = 0;
	this.world._y = 0;
	var result = this.world.wall.hitTest(hitbox._x, hitbox._y, true);
	this.world._x = x_now;
	this.world._y = y_now;
	return result;
}
