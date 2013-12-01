class CameraControl {
	private var cam:Camera;
	private var cameraSetup:Boolean;
	
	public function CameraControl(){
		cameraSetup = setup();
	}
	public function cameraAvailable():Boolean {
		if(cameraSetup){
			return true;
		} else {
			setup();
			return false;
		}
	}
	public function getCamera():Camera {
		return cam;
	}
	private function setup():Boolean{
		//get the default camera
		//change your Default camera using the Flash Player Settings.
		cam = Camera.get();
		
		//this event is called whenever permission to access the local camera, is accepted or denied by the user
		cam.onStatus=function(e){
			//if we are given permission
			if(e.code == "Camera.Unmuted") {
				return true;
			} else {
				System.showSettings(3)
				return false;
			}
		}
		
		//if there are no Cameras
		if(cam == null){
			System.showSettings(3)
			return false;
		} else {
			return true;
		}
	}
}