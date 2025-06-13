extends Sprite2D


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	_double_check()
	await get_tree().create_timer(0.1).timeout
	_double_check()


#@ Private Methods
func _double_check():
	if Automation.contains("Spinbot"):
		show()
	else:
		hide()
