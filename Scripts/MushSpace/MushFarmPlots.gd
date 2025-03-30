extends Node
class_name MushFarmPlots


#@ Signals


#@ Onready Variables
@onready var plots : Array[Node2D] = [$Plot1, $Plot2, $Plot3, $Plot4]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateSprites()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods


#@ Private Methods
func updateSprites():
	## TODO: Inefficient. Example: If plot has a mushroom, then it will unhide. Once this is called again, it will hide and then unhide. No need to continue hiding.
	for plot in plots:
		plot.hide()
	
	
	var timeBasedOnType = 0
	var timeBasedOnLevel = 0
	var post10scaling = 1
	if(GVars.mushroomData.level > 10):
		post10scaling = GVars.mushroomData.level - 10 + 3
	
	if(GVars.curEmotionBuff == 3):
		timeBasedOnType = 30 * post10scaling
		timeBasedOnLevel = 5 * post10scaling
	else:
		timeBasedOnType = 15 * post10scaling
		timeBasedOnLevel = 10 * post10scaling
	
	for n in GVars.mushroomData.currentFarmPlots.size():
		if GVars.mushroomData.currentFarmPlots[n]:
			var plot : Node2D = plots[n]
			var sprite : Sprite2D = plot.get_node("MushroomSprite")
			var timeCounter : Label = plot.get_node("TimeCounter")
			
			plots[n].show()
			sprite.texture = load(GVars.mushroomData.currentFarmPlots[n].spritePath)
			var newScaleVal : float = 1 - GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.currentFarmPlots[n].baseHarvestTimeMultiplier * timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel) + 0.01
			sprite.scale = Vector2(newScaleVal, newScaleVal)
			timeCounter.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
