interface src.States.State {
    public function Enter():Void; // called on entering the state
    
    public function Exit():Void; // called on leaving the state

    public function onEnterFrame():Void; // called every frame while in the state

    public function ExitFinished():Boolean; // Gets called each frame until it returns true. Next state will not be entered unless exit finished (e.g. Wait for animations to finish)
}
