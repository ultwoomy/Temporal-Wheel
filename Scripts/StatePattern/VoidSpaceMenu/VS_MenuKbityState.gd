extends VS_MenuState
class_name VS_MenuKbityState


#@ Virtual Methods
func _enter() -> void:
	super._enter()
	
	# Display the default visuals.
	voidSpace.busStopBackground.set_texture(load("res://Sprites/VoidSpace/bus_stop.png"))
	voidSpace.busStopBackground.scale = Vector2(2, 2)
	voidSpace.busStopBackground.position = Vector2(500, 300)
	
	voidSpace.kbityShop.show()
	
	
	# Connect signals as to wait for the Player to choose a menu to go into.


func _exit() -> void:
	voidSpace.kbityShop.hide()
	#@ Disconnect signals.
	# Allows backButton to function differently depending on states.
	voidSpace.backButton.pressed.disconnect(_onBackButtonPressed)


func _onBackButtonPressed() -> void:
	voidSpace.changeState(VS_MenuPickState.new(voidSpace))
