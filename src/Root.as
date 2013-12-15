_xscale=200;
_yscale=200;

var xKugelspeed = 0;
var yKugelspeed = 0;
var vNolight = 0;
var vNokugel =0;
var vQuality = "high"
var vMusic = 1;
_quality = vQuality;
var vWalls =  new Array(
	_root.world.wall.wall1,
	_root.world.wall.wall2,
	_root.world.wall.wall3,
	_root.world.wall.wall4
	)

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
	trace("Adding enemy: " + enemy)
	vEnemiesList.push(enemy);
}

function removeEnemy(enemy) {
	trace("Removing enemy: " + enemy + " from list :" + vEnemiesList);
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

function hitsEnemies(hitbox):Array {
	var returnArray = new Array();
	for (var i = 0, i < vEnemiesList.length, i++) {
		if (hitbox.hitTest(vEnemiesList[i])) {
			returnArray.push(vEnemiesList[i]);
		}
	}
	return returnArray;
}
