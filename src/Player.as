package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Player extends MovieClip {
		
		private var speed:Number = 5;
		private var rootRef:Root;
		
		
		private var _direction;
		
		
		public function Player() {
			this.rootRef = root as Root;
			this.rootRef.player = this;
			_direction = Directions.DOWN;
			addEventListener(Event.ENTER_FRAME,loop,false,0,true);
		}
		
		public function get Direction():String {
			
			if (this.rootRef.upPressed) {
				_direction =  Directions.UP;
			}
			if (this.rootRef.downPressed) {
				_direction =  Directions.DOWN;
			}
			if (this.rootRef.leftPressed) {
				_direction =  Directions.LEFT;
			}
			if (this.rootRef.rightPressed) {
				_direction =  Directions.RIGHT;
			}
			
			return _direction;
		}
		
		public function get Action():String {
			if (this.rootRef.leftPressed || this.rootRef.upPressed || this.rootRef.rightPressed || this.rootRef.downPressed) {
				return Actions.WALK;
			} else {
				return Actions.IDLE;
			}
		}
		
		
		private function collidesWithWall(x_next:Number, y_next:Number) {

			for each (var wall:Wall in this.rootRef.walls)  {
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

		
		public function loop(e:Event):void {
			
			//this.parent.setChildIndex(this, this.y as int);
			var xchange = 0;
			var ychange = 0;
				if(this.rootRef.leftPressed){
					xchange -= speed;
				} else if(this.rootRef.rightPressed){
					xchange += speed;
				}
				
				if(this.rootRef.upPressed){
					ychange -= speed;
				} else if(this.rootRef.downPressed){
					ychange += speed;
				}
				
			if (!collidesWithWall(this.x + xchange, this.y + ychange)) {
				this.x += xchange;
				this.y += ychange;
			}
			
			this.animations.gotoAndPlay(this.Action + "_" + this.Direction	+ "_sword");
			
		}

	}
	
}
