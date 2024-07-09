extends Node
# Global script.


#@ Signals
signal sceneChanged


#@ Constants
const WHEELSPACE : String = "res://Scenes/WheelSpace/WheelSpace.tscn"
const SETTINGS : String = "res://Scenes/settings.tscn"
const CREDITS : String = "res://Scenes/Credits.tscn"
const TRAVELSPACE : String = "res://Scenes/TravelSpace.tscn"
const ASCENSIONSPACE : String = "res://Scenes/AscensionSpace.tscn"
const RUSTSPACE_OUTSIDE : String = "res://Scenes/RustSpaceOutside.tscn"
const PACKSMITH : String = "res://Scenes/Packsmith/Packsmith.tscn"
const ATLAS : String = "res://Scenes/Atlas.tscn"
const VOIDSPACE_STOP : String = "res://Scenes/VoidSpaceStop.tscn"
const HELLSPACE : String = "res://Scenes/HellSpace.tscn"
const MUSHSPACE : String = "res://Scenes/MushSpace/MushSpace.tscn"
const PRE_ASCENSIONSPACE : String = "res://Scenes/PreAscSpace.tscn"
const NIGHT_LOSS : String = "res://Scenes/NighChallengeLoss.tscn"


#@ Public Methods
func changeSceneToFilePath(filePath : String) -> void:
	# Get scene tree and error checks if it can get it.
	var sceneTree : SceneTree = get_tree()
	if not sceneTree:
		printerr("ERROR: Unable to get scene tree and change scene!")
		return
	
	var packedScene : PackedScene = load(filePath)
	if not packedScene:
		printerr("ERROR: Unable to get a PackedScene from file path, \"", filePath, "\"! Unable to change scene!")
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
