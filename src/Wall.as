package {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	
	public class Wall extends MovieClip {
		
		public var rootRef:Root;
		
		
		public function Wall() {
			this.rootRef = root as Root;
			this.rootRef.addWall(this);
			addEventListener(Event.ENTER_FRAME,setUpInFrame,false,0,true);
		}
		
//		public function Wall(x:Number, y:Number) {
//			// constructor code
//			this.x = x;
//			this.y = y;
//			
//			addEventListener(Event.ENTER_FRAME,setUpInFrame,false,0,true);
//			
//		}
		
		public function setUpInFrame(e:Event) {
			
			this.adjustToWalls();
			
			removeEventListener(Event.ENTER_FRAME, setUpInFrame, false);
		}
		
		private function adjustToWalls() {
			var isBelow:Boolean;
			var isAbove:Boolean;
			
			for each (var wall:Wall in this.rootRef.walls) {
				if (!isBelow) {
					isBelow = isWallBelow(wall);
				}
				if (!isAbove) {
					isAbove= isWallAbove(wall);
				}
			}
			
			if (isBelow && isAbove) {
				trace("setting up wall middle")
				this.gotoAndStop(2);
			} else if (isBelow) {
				
				trace("setting up wall low end")
				this.gotoAndStop(3);
			} else {
				
				trace("setting up wall high end")
				this.gotoAndStop(1);
			}
			
		}
		
		private function isWallAbove(other:Wall) {
			return Math.abs(other.x - this.x) < 20 && (other.y > this.y && Math.abs(other.y - this.y) < 150)
		}
		
		private function isWallBelow(other:Wall) {
			return  Math.abs(other.x - this.x) < 20 && (other.y < this.y && Math.abs(other.y - this.y) < 150)
		}
	}
	
}
