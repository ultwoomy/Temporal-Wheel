extends Node
class_name MushFarmButtons


#@ Signals


#@ Onready Variables
# Buttons to be connected by other classes.
@onready var plantButton : Button = $PlantButton
@onready var harvestButton : Button = $HarvestButton
@onready var removeButton : Button = $DeleteButton


#@ Public Variables


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## L.B: What is this for?
	GVars.mushroomData.fearMushBuff = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func autoHarvest():
	var replantOrder = [-1,-1,-1,-1]
	for n in GVars.mushroomData.current.size():
		replantOrder[n] = GVars.mushroomData.current[n]
	# TODO: HARVEST CALL SHOULD CALL A SIGNAL.
	#_harvest()
	for n in GVars.mushroomData.current.size():
		if replantOrder[n] > 0:
			_plantSpecific(replantOrder[n],n)


#@ Private Methods
func _plantSpecific(mushroomType, plotNo) -> void:
	var post10scaling = 1
	if(GVars.mushroomData.current[plotNo] == 0):
		GVars.mushroomData.current[plotNo] = mushroomType
		if(GVars.mushroomData.level > 10):
			post10scaling = GVars.mushroomData.level - 8
		if(GVars.curEmotionBuff == 3):
			GVars.mushroomData.timeLeft[plotNo] = mushroomType * 30 * post10scaling + GVars.mushroomData.level * 5 * post10scaling
		else:
			GVars.mushroomData.timeLeft[plotNo] = mushroomType * 15 * post10scaling + GVars.mushroomData.level * 10 * post10scaling
		get_window().get_node("EventManager").mushroom_planted.emit()
