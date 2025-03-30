extends Node
class_name MushFarmSelector


#@ Signals
signal mushroomSelectionChanged


#@ Enumerators
enum MushroomCrops {
	LAMP,  # 0
	ROT,  # 1
	WINE,  # 2... etc
	TWIN,
	FEAR,
}


#@ Public Variables
var unlockedCrops : Array[MushroomCrops] = [  # Default unlocked crops.
	MushroomCrops.LAMP,
	MushroomCrops.ROT,
	MushroomCrops.WINE,
	MushroomCrops.TWIN,
]


#@ Private Variables
var _mushroomSelected : MushroomCrops = 0  # 0 is the first item in the enumerator, which will be the current selected mushroom crop.


#@ Virtual Methods
func _ready() -> void:
	_unlockCrops()


#@ Public Methods
# Gets the MushroomCrop resource for the mushroom selected.
func getMushroomCropResource() -> MushroomCrop:
	# Load in the mushroom crop resources.
	const MUSHROOM_CROPS_RESOURCES : Dictionary = {
		MushroomCrops.LAMP: preload("res://Resources/Mushroom Crop/Lamp.tres"),
		MushroomCrops.ROT: preload("res://Resources/Mushroom Crop/Rot.tres"),
		MushroomCrops.WINE: preload("res://Resources/Mushroom Crop/Wine.tres"),
		MushroomCrops.TWIN: preload("res://Resources/Mushroom Crop/Twin.tres"),
		MushroomCrops.FEAR: preload("res://Resources/Mushroom Crop/Fear.tres"),
	}
	
	# Get the mushroom crop that matches _mushroomSelected.
	var newMushroomCrop : MushroomCrop = MUSHROOM_CROPS_RESOURCES.get(_mushroomSelected)
	
	# Error checking
	if not newMushroomCrop:
		printerr("ERROR: Unable to get correct mushroom crop resource for the mushroom crop selected!")
	
	return newMushroomCrop


func selectNextCrop() -> void:
	_mushroomSelected += 1
	if _mushroomSelected >= unlockedCrops.size():
		_mushroomSelected = 0
	mushroomSelectionChanged.emit()  # Signals that the current mushroom selected has changed.


func selectPreviousCrop() -> void:
	_mushroomSelected -= 1
	if _mushroomSelected < 0:
		_mushroomSelected = unlockedCrops.size() - 1
	mushroomSelectionChanged.emit()  # Signals that the current mushroom selected has changed.


#@ Private Methods
func _unlockCrops() -> void:
	# Unlocks fear mushroom.
	if GVars.fearcatData.hasBow:
		unlockedCrops.append(MushroomCrops.FEAR)
