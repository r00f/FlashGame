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
	this.attachMovie("blood_splatter","newblood_splatter", this.getNextHighestDepth());
}

function regenerateHealth() {
	if (this.getHealthPoints() < this.vMaxHealth) {
		this.changeHealth(vHealthRegeneration);
	}
}
function changeHealth(change) {
	this.vHealthPoints += change;
}
