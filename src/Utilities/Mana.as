var vMaxMana = 100;
var vManaPoints =  100;
var vManaRegeneration:Number = 0.5;

function getManaPoints() {
	return this.vManaPoints;
}
function getManaPercentage() {
	return 1.0/this.vMaxMana * this.vManaPoints;
}
function spendMana(points:Number) {
	this.changeMana(-points);
}

onClipEvent(enterFrame) {
	this.regenerateMana();
}


// Helper Functions
function regenerateMana() {
	if (this.getManaPoints() < this.vMaxMana) {
		this.changeMana(vManaRegeneration);
	}

function changeMana(change) {
	this.vManaPoints += change;
}
