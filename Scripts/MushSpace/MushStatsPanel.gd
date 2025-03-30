extends Control
class_name MushStatsPanel


#@ Onready Variables
@onready var statsDisp : Label = $StatsDisp


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().get_node("EventManager").mushroom_planted.connect(_updateStats)
	_updateStats()
	mushbotCheck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func mushbotCheck():
	if Automation.contains("Mushbot"):
		WheelSpinner.wheelRotationCompleted.connect(_updateStats)


#@ Private Methods
func _updateStats() -> void:
	statsDisp.text = "Buffs\n"
	statsDisp.text += "Spin Buff: " + str(GVars.getScientific(GVars.mushroomData.spinBuff)) + "\n"
	statsDisp.text += "Identity Buff: " + str(GVars.getScientific(GVars.mushroomData.ascBuff)) + "\n"
	statsDisp.text += "Mush Grow Speed: " + str(GVars.getScientific(GVars.mushroomData.fearMushBuff))
