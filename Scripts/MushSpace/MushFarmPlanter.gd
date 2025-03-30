extends Node
class_name MushFarmPlanter


#@ Signals
signal mushroomPlanted


#@ Enumerators


#@ Constants


#@ Global Variables


#@ Public Methods
func plant(crop : MushroomCrop) -> void:
	var post10scaling = 1
	for n in GVars.mushroomData.currentFarmPlots.size():
		if not GVars.mushroomData.currentFarmPlots[n]:  # Checks to see if the farm plot does NOT have a crop in it.
			GVars.mushroomData.currentFarmPlots[n] = crop  # Have the farm plot plant the new selected mushroom crop.
			if GVars.mushroomData.level > 10:
				post10scaling = GVars.mushroomData.level - 8
			
			# Reset harvest time and set it depending on mushroom crop and level.
			if GVars.curEmotionBuff == 3:
				GVars.mushroomData.timeLeft[n] = (crop.baseHarvestTimeMultiplier * 30 + GVars.mushroomData.level * 5) * post10scaling
			else:
				GVars.mushroomData.timeLeft[n] = (crop.baseHarvestTimeMultiplier * 15 + GVars.mushroomData.level * 10) * post10scaling
			
			mushroomPlanted.emit()
			return  # Stops planting any more of the crop once an empty plot is found.
