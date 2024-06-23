extends State
class_name VS_MenuState


#@ Global Variables
var voidSpace : VoidSpaceMain


#@ Virtual Methods
func _init(_voidSpace : VoidSpaceMain) -> void:
	voidSpace = _voidSpace


# Derived classes should call super._enter() in their _enter() function.
func _enter() -> void:
	# Connect signals.
	if not voidSpace.backButton.pressed.is_connected(_onBackButtonPressed):
		voidSpace.backButton.pressed.connect(_onBackButtonPressed)


func _onBackButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)
