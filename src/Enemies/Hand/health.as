var vMaxHealth = 100;
var vHealthRegeneration:Number = 0;
var vHealthPoints =  100;

function getHealthPoints() {
	return this.vHealthPoints;
}

function getHealthPercentage() {
	return 1.0/this.vMaxHealth * this.vHealthPoints;
}

function Hit(damage:Number) {
	this.changeHealth(-damage);
}

function knockback(xDistance:Number, yDistance:Number) {
	x_next += xDistance;
	y_next += yDistance;
}

this.onEnterFrame = function()
{
	
	this.regenerate();
}

function regenerate() {
	if (this.getManaPoints() < this.vMaxMana) {
		this.changeMana(vManaRegeneration);
		this.changeHealth(vHealthRegeneration);
	}
}
function changeHealth(change) {
	this.vHealthPoints += change;	
}
