extends Node
class_name MushFarmRemover


#@ Public Methods
func remove() -> void:
	for n in GVars.mushroomData.currentFarmPlots.size():
		if GVars.mushroomData.currentFarmPlots[n]:
			GVars.mushroomData.currentFarmPlots[n] = null
			GVars.mushroomData.timeLeft[n] = 0
	get_window().get_node("EventManager").mushroom_planted.emit()
