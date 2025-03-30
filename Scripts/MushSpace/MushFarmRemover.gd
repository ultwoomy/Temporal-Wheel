extends Node
class_name MushFarmRemover


#@ Signals
signal mushroomsRemoved

#@ Public Methods
# Clarification: Will remove mushroom crops from the farm plots.
func remove() -> void:
	for n in GVars.mushroomData.currentFarmPlots.size():
		if GVars.mushroomData.currentFarmPlots[n]:
			GVars.mushroomData.currentFarmPlots[n] = null
			GVars.mushroomData.timeLeft[n] = 0
	get_window().get_node("EventManager").mushroom_planted.emit()
	mushroomsRemoved.emit()
