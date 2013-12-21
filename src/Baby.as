package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Baby extends MovieClip {
		
		private var HorizontalLimit = 100;
		private var VerticalLimit = 50;
		
		private var rootRef:Root;
		
		private var speed:Number;
		private var xspeed:Number;
		private var yspeed:Number;
		private var direction:String;
		private var nextAction:String = "idle";
		

		
		private var FixPositionX;
		private var FixPositionY;
		
		private var Wait ;
		public function Baby() {
			// constructor code
			this.rootRef = this.root as Root;
			Wait = rootRef.random(25); ;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			FixPositionX = int(this.x);
			FixPositionY  = int(this.y);
			this.speed = rootRef.random(6)+2;
			xspeed = this.speed;
			yspeed = 0;
			this.direction = Directions.RIGHT;
		}
		
		
		
		public function loop(e:Event):void {
			if (Wait > 0) {
				Wait--;
				return;
			}
			if (this.x < (FixPositionX - HorizontalLimit)) {
				xspeed = this.speed;
				this.direction = Directions.RIGHT;
			}
			if (this.x > (FixPositionX + HorizontalLimit)) {
				
				xspeed = -this.speed;
				this.direction =  Directions.LEFT;
			}
			
			if (this.y > (FixPositionY + VerticalLimit)) {
				yspeed = -this.speed;
				this.direction =  Directions.UP;
			}
			
			if (this.y < (FixPositionY - VerticalLimit)) {
				yspeed = this.speed;
				this.direction =  Directions.DOWN;
			}
			
			if ((xspeed != 0 || yspeed != 0)) {
				if (this.rootRef.collidesWithWall(this.x + xspeed, this.y + yspeed) || this.rootRef.collidesWithWall(this.x + xspeed + this.width*2/3, this.y + yspeed)) {
					xspeed = -xspeed;
					this.direction = Directions.oppositeOf(this.direction);
				}
				this.nextAction = "baby_walk_";
				this.x += xspeed;
				this.y += yspeed;
			}
			animations.gotoAndStop(this.nextAction+this.direction);
		}
	}
	
}
