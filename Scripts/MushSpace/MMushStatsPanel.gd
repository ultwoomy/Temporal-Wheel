extends Sprite2D


## Components
@onready var statsDisp : Label = $StatsDisp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().get_node("EventManager").mushroom_planted.connect(_update_stats)
	_update_stats()
	mushbotCheck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _update_stats() -> void:
	statsDisp.text = "Buffs\nSpin Buff: " + str(GVars.getScientific(GVars.mushroomData.spinBuff)) + "\nIdentity Buff: " + str(GVars.getScientific(GVars.mushroomData.ascBuff)) + "\nMush Grow Speed: " + str(GVars.getScientific(GVars.mushroomData.fearMushBuff))

func mushbotCheck():
	if Automation.contains("Mushbot"):
		WheelSpinner.wheelRotationCompleted.connect(_update_stats)
