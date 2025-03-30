extends Node
class_name MushFarmAutomator

## NOTE: MushFarmAutomator currently does NOTHING.
## The two functions- autoHarvest & autoReplant -have some quirks and issues!
##  1. The MushFarmAutomator only works when you're in the scene. Intentional or not.
##  2. Signalling is required since the functionality of harvesting/planting are in different scripts.
##     - However, when should MushFarmAutomator call signal to automate?

#@ Public Variables
var replantOrder : Array[MushroomCrop] = [null, null, null, null]


#@ Public Methods
' L.B: Since harvesting is easy (just call Harvester.harvest(), it\'ll check all plots), this function probably shouldn\'t be necessary.
	- Just have a new function to change the replantOrder, or just change the variable itself.
func autoHarvest() -> void:
	for n in GVars.mushroomData.current.size():
		replantOrder[n] = GVars.mushroomData.current[n]
	# TODO: HARVEST CALL SHOULD CALL A SIGNAL.
	#_harvest()
'

func autoReplant() -> void:
	for n in GVars.mushroomData.current.size():
		if replantOrder[n]:
			return
			#_plantSpecific(replantOrder[n], n)
