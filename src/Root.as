package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Root extends MovieClip {
		
		var healthbar:HealthBar =  new HealthBar(100, 100, 0.5, 0.5) ;
		private var _walls:Array = new Array();
		
		public function Root() {
			// constructor code
			healthbar = new HealthBar(100, 100, 0.5, 0.5);	
			stage.addChild(healthbar);
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
//		
//			
//			for (var i:int = 0; i <7 ; i++) {
//				var wall:Wall = new Wall(300, 150+i*105, this);
//				walls.push(wall);
//				stage.addChild(wall);
//			}
//			
		}
		
		var wait = 10;

		public function get walls():Array
		{
			return _walls;
		}
		
		public function addWall(wall:Wall) {
			this.walls.push(wall);
		}

		public function loop(e:Event):void {
			
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
		}
	}
	
}
