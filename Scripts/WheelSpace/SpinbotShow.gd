extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(get_window().get_node_or_null("Spinbot")):
		show()
	else:
		hide()
	await get_tree().create_timer(0.1).timeout
	_double_check()
	
func _double_check():
	if(get_window().get_node_or_null("Spinbot")):
		show()
	else:
		hide()

