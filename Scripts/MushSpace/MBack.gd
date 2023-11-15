extends Node
@export var back : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	back.pressed.connect(self._wheel_scene)


func _wheel_scene():
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
