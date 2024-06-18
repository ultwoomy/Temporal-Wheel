extends Node
@export var button : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(self._button_pressed)

func _button_pressed():
	var event_manager = get_tree().get_root().find_child("EventManager", true, false)
	event_manager.emit_signal("scene_change",true)
	get_tree().change_scene_to_file("res://Scenes/WheelSpace/WheelSpace.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
