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
		
		

		
		public function loop(e:Event):void {
			
			//this.parent.setChildIndex(this, this.y as int);
			if(this.rootRef.leftPressed){
				x -= speed;
			} else if(this.rootRef.rightPressed){
				x += speed;
			}
			
			if(this.rootRef.upPressed){
				y -= speed;
			} else if(this.rootRef.downPressed){
				y += speed;
			}
			
			this.animations.gotoAndPlay(this.Action + "_" + this.Direction	+ "_sword");
			
		}

	}
	
}
