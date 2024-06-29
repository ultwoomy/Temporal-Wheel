extends VS_MenuState
class_name VS_MenuPickState


#@ Virtual Methods
func _enter() -> void:
	super._enter()
	
	# Display the default visuals.
	voidSpace.busStopBackground.set_texture(load("res://Sprites/VoidSpace/bus_stop.png"))
	voidSpace.busStopBackground.scale = Vector2(2, 2)
	voidSpace.busStopBackground.position = Vector2(500, 300)
	
	voidSpace.sigilButton.show()
	voidSpace.unlockRitualButton()
	voidSpace.unlockKbityButton()
	
	# Connect signals as to wait for the Player to choose a menu to go into.
	if not voidSpace.sigilButton.pressed.is_connected(voidSpace.changeState):
		voidSpace.sigilButton.pressed.connect(voidSpace.changeState.bind(VS_MenuSigilState.new(voidSpace)))
	if not voidSpace.ritualButton.pressed.is_connected(voidSpace.changeState):
		voidSpace.ritualButton.pressed.connect(voidSpace.changeState.bind(VS_MenuRitualState.new(voidSpace)))
	if not voidSpace.kbityButton.pressed.is_connected(voidSpace.changeState):
		voidSpace.kbityButton.pressed.connect(voidSpace.changeState.bind(VS_MenuKbityState.new(voidSpace)))


func _exit() -> void:
	voidSpace.sigilButton.hide()
	voidSpace.ritualButton.hide()
	voidSpace.kbityButton.hide()
