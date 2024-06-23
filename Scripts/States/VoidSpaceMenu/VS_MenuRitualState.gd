extends VS_MenuState
class_name VS_MenuRitualState


#@ Virtual Methods
func _enter() -> void:
	super._enter()
	
	# Open the ritual shop.
	voidSpace.busStopBackground.set_texture(load("res://Sprites/VoidSpace/bunny_zoom_2.png"))
	voidSpace.busStopBackground.scale = Vector2(6, 6)
	voidSpace.busStopBackground.position = Vector2(400, 230)
	
	voidSpace.ritualShop.show()


func _update(_delta: float) -> void:
	pass


func _exit() -> void:
	voidSpace.ritualShop.hide()
	
	#@ Disconnect signals.
	# Allows backButton to function differently depending on states.
	voidSpace.backButton.pressed.disconnect(_onBackButtonPressed)


func _onBackButtonPressed() -> void:
	voidSpace.changeState(VS_MenuPickState.new(voidSpace))
