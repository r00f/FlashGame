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
		private var _attackPressed:Boolean = false; //...down key pressed
		
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
		
		public function get attackPressed():Boolean
		{
			return _attackPressed;
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
				var offsetElse:Number = 10;
				if (wall.isDoor && wall.doorOpen) {
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
			if(key.isDown(KeyCodes.LeftArrow) || key.isDown(KeyCodes.A)){ // if left arrow or A is pressed
				_leftPressed = true;
			} else {
				_leftPressed = false;
			}
			
			if(key.isDown(KeyCodes.UpArrow) || key.isDown(KeyCodes.w)){ // if up arrow or W is pressed
				_upPressed = true;
			} else {
				_upPressed = false;
			}
			
			if(key.isDown(KeyCodes.RightArrow) || key.isDown(KeyCodes.d)){ //if right arrow or D is pressed
				_rightPressed = true;
			} else {
				_rightPressed = false;
			}
			
			if(key.isDown(KeyCodes.DownArrow) || key.isDown(KeyCodes.s)){ //if down arrow or S is pressed
				_downPressed = true;
			} else {
				_downPressed = false;
			}
			
			if(key.isDown(KeyCodes.Spacebar)){ //if down arrow or S is pressed
				_attackPressed = true;
			} else {
				_attackPressed = false;
			}
		}
		
		public function random(n:int) {
			return ((int)(Math.random()*1000)) %n;
		}
		
		public function collidesWithWall(x_next:Number, y_next:Number) {
			
			for each (var wall:Wall in this.walls)  {
				if (wall.isDoor) {
					if (wall.door == null) {
						continue;
					}
					var door:MovieClip = wall.door;
					if (door.hitbox1.hitTestPoint(x_next, y_next,false) ){
						return true;
					}
					if (door.hitbox2 != null && door.hitbox2.hitTestPoint(x_next, y_next,false)) {
						return true;
					}
				} else if (wall.hitbox.hitTestPoint(x_next, y_next,false)) {
					return true;
				}
				
			}
			return false;
			
		}
	}
	
	

	
}
