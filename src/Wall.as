package {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

	
	
	public class Wall extends MovieClip {
		
		public var rootRef:Root;
		
		private const TOPEND:Number = 1;
		private const VERTICAL_MIDDLE:Number = 2;
		private const BOTTOMEND:Number = 3;
		private const LEFTEND:Number = 4;
		private const RIGHTEND:Number = 5;
		private const HORIZONTAL_MIDDLE:Number = 6;
		private const HORIZONTAL_DOOR:Number = 7;
		
		private const HORIZONTAL_DOOR_NAME:String = "HorizontalDoor";
		
		
		public function Wall() {
			this.rootRef = root as Root;
			this.rootRef.addWall(this);
			addEventListener(Event.ENTER_FRAME,setUpInFrame,false,0,true);
		}
	private var foundOther = false;
		
		public function setUpInFrame(e:Event) {
			this.adjustToWalls();
			removeEventListener(Event.ENTER_FRAME, setUpInFrame, false);
		}
		
		private function adjustToWalls() {
			var isBelow:Boolean = false;
			var isAbove:Boolean = false;
			var isRight:Boolean = false;
			var isLeft:Boolean = false;
			
			this.foundOther = true;
			var aboveWall:Wall;
			var belowWall:Wall;
			var rightWall:Wall;
			var leftWall:Wall;
			
			for each (var wall:Wall in this.rootRef.walls) {
				if (wall != this) {
					if (!isBelow) {
						if (isWallBelow(wall)) {
							aboveWall = wall;
							isBelow = true;
						}
					}
					if (!isAbove) {
						if (isWallAbove(wall)) {
							belowWall = wall;
							isAbove = true;
						}
					}
					if (!isRight) {
						if (isWallRight(wall)) {
							leftWall = wall;
							isRight = true;
						}
					}
					if (!isLeft) {
						if (isWallLeft(wall)) {
							rightWall = wall;
							isLeft = true;
						}
					}
				}
			}
			
			if (isBelow && isAbove && isRight && isLeft) {
				trace("central part, need more animations");
			}
			if (isBelow && isAbove) {
				var middle = aboveWall.y - (aboveWall.y - belowWall.y)/2;
				this.x = belowWall.x;
				this.y = middle;
				this.gotoAndStop(VERTICAL_MIDDLE);
			} else if (isRight && isLeft) {
				this.gotoAndStop(HORIZONTAL_MIDDLE);
				this.y = leftWall.y;
				this.x = leftWall.x + (this.width - 3);
			} else if (isBelow) {
				this.gotoAndStop(BOTTOMEND);
				this.x = aboveWall.x;
				this.y = aboveWall.y + this.height;
				
			} else if (isAbove) {
				this.gotoAndStop(TOPEND);
				this.x = belowWall.x;
				this.y = belowWall.y - this.height + 13;
			} else if (isRight) {
				this.gotoAndStop(RIGHTEND);
				this.y = leftWall.y;
				this.x = leftWall.x + (this.width -3);
			} else if (isLeft) {
				trace("left" + this.width + " - " + this)
				this.gotoAndStop(LEFTEND);
				this.y = rightWall.y;
				
				this.x = rightWall.x - (this.width-3);
			} else {
				this.foundOther = false;
				var random = ((int)(Math.random()*100))%7+1;
				
				trace("nothing near");
				this.gotoAndStop(random);
			}	
			
			if (this.name == HORIZONTAL_DOOR_NAME) {
				this.gotoAndStop(HORIZONTAL_DOOR);
			}
			
		}
		
		private function isWallAbove(other:Wall) {
			return Math.abs(other.x - this.x) < 10 && (other.y > this.y && Math.abs(other.y - this.y) < 150)
		}
		
		private function isWallBelow(other:Wall) {
			return  Math.abs(other.x - this.x) < 10 && (other.y < this.y && Math.abs(other.y - this.y) < 150)
		}
		private function isWallRight(other:Wall) {
			return Math.abs(other.y - this.y) < 10 && (other.x < this.x && Math.abs(other.x - this.x) < 250)
		}
		
		private function isWallLeft(other:Wall) {
			return  Math.abs(other.y - this.y) < 10 && (other.x > this.x && Math.abs(other.x - this.x) < 250)
		}
	}
	
}
