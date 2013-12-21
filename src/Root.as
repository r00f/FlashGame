package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import vendor.KeyObject;
	
	
	public class Root extends MovieClip {
		
		var healthbar:HealthBar =  new HealthBar(100, 100, 0.5, 0.5) ;
		private var _walls:Array = new Array();
		
		private var key:KeyObject;
		private var _leftPressed:Boolean = false; //keeps track of whether the left arrow key is pressed
		private var _rightPressed:Boolean = false; //same, but for right key pressed
		private var _upPressed:Boolean = false; //...up key pressed
		private var _downPressed:Boolean = false; //...down key pressed
		
		
		public var player:Player;
		
		public function Root() {
			// constructor code
			healthbar = new HealthBar(100, 100, 0.5, 0.5);	
			stage.addChild(healthbar);
			
			key = new KeyObject(this.stage);
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
						
		}
		
		var wait = 10;
		
		
		// Keys

		public function get downPressed():Boolean
		{
			return _downPressed;
		}

		public function get upPressed():Boolean
		{
			return _upPressed;
		}

		public function get rightPressed():Boolean
		{
			return _rightPressed;
		}

		public function get leftPressed():Boolean
		{
			return _leftPressed;
		}

		public function get walls():Array
		{
			return _walls;
		}
		
		public function addWall(wall:Wall) {
			this.walls.push(wall);
		}

		public function loop(e:Event):void {
			this.checkKeypresses();
			if (wait <= 0) {
				
				if (healthbar.currentHealth <= 0) {
					healthbar.currentHealth = 200;
				} else {
					healthbar.currentHealth = healthbar.currentHealth - 10;
				}
				wait = 10;
			} else {
				wait--;
			}
			
			
			for each (var wall:Wall in this.walls) 
			{
				var offsetDoor:Number = 35;
				var offsetElse:Number = 15;
				if (wall.isDoor) {
					if (Math.abs(this.player.x - wall.x) < 25) {
						if (shouldSwapWithPlayer(wall, offsetDoor)) {
							swapChildren(wall, player);
						}
					} else {
						if (shouldSwapWithPlayer(wall, offsetElse)) {
							swapChildren(wall, player);
						}
					}
				}else if (shouldSwapWithPlayer(wall, offsetElse)) {
					swapChildren(wall, player);
				}
				
					
				
			}
			
		}
		
		private function shouldSwapWithPlayer(wall:Wall, offset:Number):Boolean {
			return (this.player.y -offset) < wall.y && getChildIndex(this.player) > getChildIndex(wall) 
				|| (this.player.y - offset) > wall.y && getChildIndex(this.player) < getChildIndex(wall) 
		}
		
		public function checkKeypresses():void
		{
			// I used http://www.dakmm.com/?p=272 as a reference to get the keyCode numbers for each key
			if(key.isDown(37) || key.isDown(65)){ // if left arrow or A is pressed
				_leftPressed = true;
			} else {
				_leftPressed = false;
			}
			
			if(key.isDown(38) || key.isDown(87)){ // if up arrow or W is pressed
				_upPressed = true;
			} else {
				_upPressed = false;
			}
			
			if(key.isDown(39) || key.isDown(68)){ //if right arrow or D is pressed
				_rightPressed = true;
			} else {
				_rightPressed = false;
			}
			
			if(key.isDown(40) || key.isDown(83)){ //if down arrow or S is pressed
				_downPressed = true;
			} else {
				_downPressed = false;
			}
		}
	}
	
	

	
}
