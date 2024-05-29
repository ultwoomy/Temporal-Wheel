extends Node


@export var back : Button


# Called when the node enters the scene tree for the first time.
func _ready():
	back.pressed.connect(self._wheel_scene)


func _wheel_scene():
	var event_manager = get_tree().get_root().find_child("EventManager", true, false)
	event_manager.emit_signal("scene_change",true)
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
