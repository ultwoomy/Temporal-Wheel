extends Node
class_name MushFarmPlanter


#@ Signals
signal mushroomPlanted


#@ Enumerators


#@ Constants


#@ Global Variables


#@ Public Methods
## Copied from MushFarmButtons.
func plant(crop : MushroomCrop) -> void:
	var post10scaling = 1
	for n in GVars.mushroomData.currentFarmPlots.size():
		if not GVars.mushroomData.currentFarmPlots[n]:  # Checks to see if the farm plot does NOT have a crop in it.
			GVars.mushroomData.currentFarmPlots[n] = crop  # Have the farm plot plant the new selected mushroom crop.
			if(GVars.mushroomData.level > 10):
				post10scaling = GVars.mushroomData.level - 8
			
			
			## TODO: Figure out what the buff does and see if it can be better before changing mushroomSelected value.
			'
			if(GVars.curEmotionBuff == 3):
				GVars.mushroomData.timeLeft[n] = (mushroomSelected + 1) * 30 * post10scaling + GVars.mushroomData.level * 5 * post10scaling  ## mushroomSelected DEPENDS ON MushroomCrops enum 
			else:
				GVars.mushroomData.timeLeft[n] = (mushroomSelected + 1) * 15 * post10scaling + GVars.mushroomData.level * 10 * post10scaling
			'
			get_window().get_node("EventManager").mushroom_planted.emit()
			mushroomPlanted.emit()
			break
