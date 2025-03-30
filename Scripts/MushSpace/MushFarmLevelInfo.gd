extends Control


#@ Export Variables
@export var xpBarProgress : Sprite2D  # L.B: I don't know whether this should be XpBar or XpBarProgress.
@export var leveldisp : Label


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateXpBar()


#@ Public Methods
func updateXpBar() -> void:
	xpBarProgress.scale.x = GVars.mushroomData.xp / GVars.mushroomData.xpThresh * 1.5
	leveldisp.text = "Level: " + str(GVars.getScientific(GVars.mushroomData.level))
