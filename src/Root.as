_xscale=200;
_yscale=200;

var xKugelspeed = 0;
var yKugelspeed = 0;
var vNolight = 0;
var vNokugel =0;
var vQuality = "high"
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
};

stop();
