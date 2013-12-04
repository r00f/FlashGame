#include "src/Utilities/Constants.as"
#include "src/Utilities/Movement.as"

import src.Enemies.Baby.BabyClass;

import src.Utilities.Directions;
/* "Documentation" 
	
	Baby
		- doAttack() : Does the attack in the next frame
		- getDirection() : Returns the direction
		- getDamage() : Returns the damage
		- getKnockback() : Returns the knoback its attack does

*/

var baby = new BabyClass(this);
this.onEnterFrame = function() {
	baby.onEnterFrame();
}


/*
	Needed for interfacing because this is the only class

*/
function doAttack() {
	baby.doAttack()
}

function getDirection() {
	return baby.getDirection();
}

function getDamage() {
	return  baby.getDamage();
}
function getKnockback() {
	return  baby.getKnockback();
}

