extends Node
@export var button : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(self._button_pressed)

func _button_pressed():
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
