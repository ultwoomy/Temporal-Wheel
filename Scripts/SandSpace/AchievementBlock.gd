extends Control
var ach : Achievement
@export var button : Button
signal achievementButtonPressed(ach)

# Called when the node enters the scene tree for the first time.
func _ready():
	if not ach == null:
		button.disabled = true
		button.text = ach.achievementName
		button.tooltip_text = ach.description
		if ach.type == "spin":
			if ach.checkComparable(GVars.spinData.spin):
				showTrue()
		if ach.type == "ifFirstAtlas":
			if ach.checkComparable(GVars.ifFirstAtlas):
				showTrue()
		if ach.type == "ifFirstFearcatNight":
			if ach.checkComparable(GVars.ifFirstFearcatNight):
				showTrue()
		if ach.type == "ifFirstFearcatDay":
			if ach.checkComparable(GVars.ifFirstFearcatDay):
				showTrue()
		if ach.type == "rotations":
			if ach.checkComparable(GVars.spinData.rotations):
				showTrue()
		if ach.type == "mushlevel":
			if ach.checkComparable(GVars.mushroomData.level):
				showTrue()


func setAch(achievement : Achievement):
	ach = achievement
	_ready()
	
func showTrue():
	button.disabled = false

func _on_button_pressed():
	achievementButtonPressed.emit(ach)
