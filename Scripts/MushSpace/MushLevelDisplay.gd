extends Control
class_name MushLevelDisplay


#@ Onready Variables
@onready var xpBarProgress : Sprite2D = $XpBarProgress
@onready var leveldisp : Label = $CurrentLevel


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_window().get_node("EventManager").mushroom_planted.connect(updateXpBar)
	updateXpBar()


#@ Public Methods


#@ Private Methods
func updateXpBar() -> void:
	while GVars.mushroomData.xp > GVars.mushroomData.xpThresh:
		GVars.mushroomData.xp -= GVars.mushroomData.xpThresh
		GVars.mushroomData.level += 1
	
	if GVars.mushroomData.level >= 10:
		xpBarProgress.modulate = Color(255,0,255)
	xpBarProgress.scale.x = GVars.mushroomData.xp / GVars.mushroomData.xpThresh * 1.5
	leveldisp.text = "Level: " + str(GVars.getScientific(GVars.mushroomData.level))
