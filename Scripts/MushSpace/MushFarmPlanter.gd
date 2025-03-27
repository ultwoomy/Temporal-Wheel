extends Node
class_name MushFarmPlanter


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

#@ Constants
const MUSHROOM_CROPS_RESOURCES : Dictionary = {
	MushroomCrops.LAMP: preload("res://Resources/Mushroom Crop/Lamp.tres"),
	MushroomCrops.ROT: preload("res://Resources/Mushroom Crop/Rot.tres"),
	MushroomCrops.WINE: preload("res://Resources/Mushroom Crop/Wine.tres"),
	MushroomCrops.TWIN: preload("res://Resources/Mushroom Crop/Twin.tres"),
	MushroomCrops.FEAR: preload("res://Resources/Mushroom Crop/Fear.tres"),
}


#@ Global Variables
var mushroomSelected : MushroomCrops = 0  # 0 is the first item in the enumerator.


#@ Public Methods
## Copied from MushFarmButtons.
func plant() -> void:
	var post10scaling = 1
	for n in GVars.mushroomData.current.size():
		if not GVars.mushroomData.currentFarmPlots[n]:  # Checks to see if the farm plot does NOT have a crop in it.
			GVars.mushroomData.currentFarmPlots[n] = _getMushroomCropResource()  # Have the farm plot plant the new selected mushroom crop.
			if(GVars.mushroomData.level > 10):
				post10scaling = GVars.mushroomData.level - 8
			if(GVars.curEmotionBuff == 3):
				GVars.mushroomData.timeLeft[n] = (mushroomSelected + 1) * 30 * post10scaling + GVars.mushroomData.level * 5 * post10scaling  ## mushroomSelected DEPENDS ON MushroomCrops enum 
			else:
				GVars.mushroomData.timeLeft[n] = (mushroomSelected + 1) * 15 * post10scaling + GVars.mushroomData.level * 10 * post10scaling
			get_window().get_node("EventManager").mushroom_planted.emit()
			break


func selectNextCrop() -> void:
	mushroomSelected += 1
	if mushroomSelected >= MushroomCrops.size():
		mushroomSelected = 0


func selectPreviousCrop() -> void:
	mushroomSelected -= 1
	if mushroomSelected < 0:
		mushroomSelected = MushroomCrops.size() - 1


#@ Private Methods
func _getMushroomCropResource() -> MushroomCrop:
	var newMushroomCrop : MushroomCrop = MUSHROOM_CROPS_RESOURCES.get(mushroomSelected)
	
	# Error checking
	if not newMushroomCrop:
		printerr("ERROR: Unable to get correct mushroom crop resource for the mushroom crop selected!")
	
	return newMushroomCrop
