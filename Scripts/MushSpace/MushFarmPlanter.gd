extends Node
class_name MushFarmPlanter


#@ Signals
signal mushroomSelectionChanged


#@ Enumerators
enum MushroomCrops {
	LAMP,
	ROT,
	WINE,
	TWIN,
	FEAR
}


#@ Global Variables
var mushroomSelected : MushroomCrops = 0  # 0 is the first item in the enumerator.


#@ Public Methods
## Copied from MushFarmButtons.
func plant() -> void:
	var post10scaling = 1
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] == 0):  ## .current[n] is the farm plot. Does it have a mushroom crop or not?
			GVars.mushroomData.current[n] = currentFrame + 1  ## the + 1 is because .current[n] uses 0 as null.
			if(GVars.mushroomData.level > 10):
				post10scaling = GVars.mushroomData.level - 8
			if(GVars.curEmotionBuff == 3):
				GVars.mushroomData.timeLeft[n] = (currentFrame + 1) * 30 * post10scaling + GVars.mushroomData.level * 5 * post10scaling
			else:
				GVars.mushroomData.timeLeft[n] = (currentFrame + 1) * 15 * post10scaling + GVars.mushroomData.level * 10 * post10scaling
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
