extends VS_MenuState
class_name VS_MenuRitualState


#@ Virtual Methods
func _enter() -> void:
	super._enter()
	
	# Open the sigil shop.
	voidSpace.busStopBackground.set_texture(load("res://Sprites/VoidSpace/sigil_bunny_zoom.png"))
	voidSpace.busStopBackground.scale = Vector2(5,5)
	voidSpace.busStopBackground.position = Vector2(600,250)
	
	voidSpace.sigilButton.hide()
	voidSpace.sigilShop.show()


func _update(_delta: float) -> void:
	pass


func _exit() -> void:
	voidSpace.sigilButton.show()
	voidSpace.sigilShop.hide()
	
	#@ Disconnect signals.
	# Allows backButton to function differently depending on states.
	voidSpace.backButton.pressed.disconnect(_onBackButtonPressed)


func _onBackButtonPressed() -> void:
	voidSpace.changeState(VS_MenuPickState.new(voidSpace))
