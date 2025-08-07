extends State
class_name VS_MenuState


#@ Constants
const backButtonDestination : String = SceneHandler.WHEELSPACE


#@ Global Variables
var voidSpace : VoidSpaceMain


#@ Virtual Methods
func _init(_voidSpace : VoidSpaceMain) -> void:
	voidSpace = _voidSpace


# Derived classes should call super._enter() in their _enter() function.
func _enter() -> void:
	# Connect signals.
	if not voidSpace.backButton.pressed.is_connected(voidSpace._changeScene):
		voidSpace.backButton.pressed.connect(voidSpace._changeScene.bind(backButtonDestination))
