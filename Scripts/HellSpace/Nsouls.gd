extends Label


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	text = str(GVars.getScientific(GVars.soulsData.souls))


func _onSoulUpgradePressed():
	text = str(GVars.getScientific(GVars.soulsData.souls))
