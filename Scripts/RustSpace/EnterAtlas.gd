extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	if not GVars.curEmotionBuff == 4 and GVars.iffirstatlas:
		hide()

func _button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Atlas.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
