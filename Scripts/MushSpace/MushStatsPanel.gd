extends Control
class_name MushStatsPanel


#@ Onready Variables
@onready var statsDisp : Label = $StatsDisp


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateStats()


#@ Public Methods


#@ Private Methods
func updateStats() -> void:
	statsDisp.text = "Buffs\n"
	statsDisp.text += "Spin Buff: " + str(GVars.getScientific(GVars.mushroomData.spinBuff)) + "\n"
	statsDisp.text += "Identity Buff: " + str(GVars.getScientific(GVars.mushroomData.ascBuff)) + "\n"
	statsDisp.text += "Mush Grow Speed: " + str(GVars.getScientific(GVars.mushroomData.fearMushBuff))
