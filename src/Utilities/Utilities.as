function setupDirection(speed:Number) {
	var playerDirection = this.vPlayer.getDirection();
	if (playerDirection == Directions.right) {
		this.vKugelSpeedX = speed;
		this.vKugelSpeedY = 0;
	} 

	if (playerDirection == Directions.left) {
		this.vKugelSpeedX = -speed;
		this.vKugelSpeedY = 0;
	}

	if (playerDirection == Directions.up) {
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = -speed;
	} 

	if (playerDirection == Directions.down) {
		this.vKugelSpeedX = 0;
		this.vKugelSpeedY = speed;
	}
}
