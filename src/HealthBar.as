package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class HealthBar extends MovieClip {
		
		
		private var maxHealth:Number = 100;
		private var _currentHealth:Number;
		
		
		public function HealthBar(x:Number, y:Number, xscale:Number, yscale: Number) {
			// constructor codemaxHealth
			this.currentHealth = this.maxHealth;
			this.x = x;
			this.y = y;
			this.scaleX = xscale;
			this.scaleY = yscale;
			
		}
		
		public function get HealthPercentage():Number {
			return 1.0/this.maxHealth* this.currentHealth;
		}


		public function get currentHealth():Number
		{
			return _currentHealth;
		}

		public function set currentHealth(value:Number):void
		{
			if (value > this.maxHealth) {
				value = this.maxHealth;
			}
			_currentHealth = value;
			this.gotoAndStop(this.HealthFrame);
		}
		
		private function get HealthFrame():int {
			return (int)(this.HealthPercentage*10+1);
		}
	
		

	}
	
}
