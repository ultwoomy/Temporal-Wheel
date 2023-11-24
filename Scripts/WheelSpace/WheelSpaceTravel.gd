extends Node

@export var button : Button
# Called when the node enters the scene tree for the first time.
func _ready():
	button.size = Vector2(200,100)
	button.text = "Travel"
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _button_pressed():
	var event_manager = get_tree().get_root().find_child("EventManager", true, false)
	event_manager.emit_signal("scene_change",false)
	get_tree().change_scene_to_file("res://Scenes/TravelSpace.tscn")
