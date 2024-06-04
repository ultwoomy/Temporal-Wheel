extends Label


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	text = str(GVars.getScientific(GVars.soulsData.souls))


func _on_soul_buy_pressed():
	text = str(GVars.getScientific(GVars.soulsData.souls))
