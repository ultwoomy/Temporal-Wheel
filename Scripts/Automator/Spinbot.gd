extends Automator
class_name Spinbot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Upon creation, enable the automator.
	enabled = true
	_automate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#func _init(_automator_data: AutomatorData) -> void:
#	super._init(_automator_data)


func _automate() -> void:
	# Must be enabled to continue _automate.
	if (!enabled):
		return
	# Find any node (preferably "EventManager") with the name "EventManager".
	var event_manager: EventManager = get_tree().get_root().find_child("EventManager", true, false)
	if (event_manager):
		event_manager.wheel_spun.emit()
	await get_tree().create_timer(automator_data.cooldown).timeout
	_automate()


#	spinPerCDisplay.text = str(GVars.getScientific(GVars.spinPerClick))
#	await get_tree().create_timer(0.1).timeout
#	spin_update_loop()
