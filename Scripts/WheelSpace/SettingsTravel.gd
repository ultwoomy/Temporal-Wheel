extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self.setScene)


func setScene():
	var event_manager = get_tree().get_root().find_child("EventManager", true, false)
	event_manager.emit_signal("scene_change",false)
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn")
