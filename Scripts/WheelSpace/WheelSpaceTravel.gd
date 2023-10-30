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
	get_tree().change_scene_to_file("res://Scenes/TravelSpace.tscn")
