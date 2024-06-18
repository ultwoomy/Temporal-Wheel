extends TextureButton


#@ Private Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._wheelScene)


func _wheelScene():
	var event_manager = get_tree().get_root().find_child("EventManager", true, false)
	event_manager.emit_signal("scene_change",true)
	SceneHandler.changeSceneToPacked(SceneHandler.WHEELSPACE)
