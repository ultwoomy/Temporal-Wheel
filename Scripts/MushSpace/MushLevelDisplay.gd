extends Control
class_name MushLevelDisplay


#@ Onready Variables
@onready var xpBarProgress : Sprite2D = $XpBarProgress
@onready var leveldisp : Label = $CurrentLevel


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().get_node("EventManager").mushroom_planted.connect(_updateXpBar)
	_updateXpBar()
	mushbotCheck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func mushbotCheck():
	if Automation.contains("Mushbot"):
		WheelSpinner.wheelRotationCompleted.connect(_updateXpBar)


#@ Private Methods
func _updateXpBar() -> void:
	while(GVars.mushroomData.xp > GVars.mushroomData.xpThresh):
		GVars.mushroomData.xp -= GVars.mushroomData.xpThresh
		GVars.mushroomData.level += 1
	if(GVars.mushroomData.level >= 10):
		xpBarProgress.modulate = Color(255,0,255)
	xpBarProgress.scale.x = GVars.mushroomData.xp / GVars.mushroomData.xpThresh * 1.5
	leveldisp.text = "Level: " + str(GVars.getScientific(GVars.mushroomData.level))
