extends Node

@export var button : Button
@export var button2 : Button
@export var button3 : Button
@export var button4 : Button
# Called when the node enters the scene tree for the first time.
func _ready():
	button.size = Vector2(500,300)
	button.position = Vector2(0,0)
	button.text = "Rust Space"
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)
	button2.size = Vector2(500,300)
	button2.position = Vector2(500,0)
	button2.text = "Void Space"
	button2.expand_icon = true
	button2.pressed.connect(self._button_pressed2)
	button3.size = Vector2(500,300)
	button3.position = Vector2(0,300)
	button3.text = "Heaven"
	button3.expand_icon = true
	button3.pressed.connect(self._button_pressed3)
	button4.size = Vector2(500,300)
	button4.position = Vector2(500,300)
	button4.text = "Hell"
	button4.expand_icon = true
	button4.pressed.connect(self._button_pressed4)
	if(!GVars.ifheaven):
		button3.disabled = true
	if(!GVars.ifhell):
		button4.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _button_pressed():
	get_tree().change_scene_to_file("res://Scenes/RustSpaceOutside.tscn")

func _button_pressed2():
	get_tree().change_scene_to_file("res://Scenes/VoidSpaceStop.tscn")
	
func _button_pressed3():
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
	
func _button_pressed4():
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
