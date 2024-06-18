extends Node
# Global script.


#@ Signals
signal sceneChanged


#@ Constants
const WHEELSPACE : PackedScene = preload("res://Scenes/WheelSpace/WheelSpace.tscn")
const SETTINGS : PackedScene = preload("res://Scenes/Settings.tscn")
const CREDITS : PackedScene = preload("res://Scenes/Credits.tscn")
const TRAVELSPACE : PackedScene = preload("res://Scenes/TravelSpace.tscn")


#@ Public Methods
func changeSceneToPacked(packedScene : PackedScene) -> void:
	# Get scene tree and error checks if it can get it.
	var sceneTree : SceneTree = get_tree()
	if not sceneTree:
		printerr("ERROR: Unable to get scene tree and change scene!")
		return
	
	# Changes the scene (deferred) and sees if there was any error in doing so.
	var errorChecker : Error = sceneTree.change_scene_to_packed(packedScene)
	if errorChecker == ERR_CANT_CREATE:
		printerr("ERROR: Unable to create the provided scene, \"", packedScene, "\"!")
		return
	elif errorChecker == ERR_INVALID_PARAMETER:
		printerr("ERROR: Scene provided is invalid! Unable to change scene!")
		return
	else:
		# Emits the signal that scene has been changed without any issue.
		sceneChanged.emit()
