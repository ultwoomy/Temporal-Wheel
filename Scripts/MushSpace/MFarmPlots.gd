extends Node

## Components
@export var plot1 : AnimatedSprite2D
@export var plot2 : AnimatedSprite2D
@export var plot3 : AnimatedSprite2D
@export var plot4 : AnimatedSprite2D
@export var disp1 : Label
@export var disp2 : Label
@export var disp3 : Label
@export var disp4 : Label


## Functions
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_sprites()
	
	get_window().get_node("EventManager").mushroom_planted.connect(_update_sprites)
	get_window().get_node("EventManager").mushroom_harvested.connect(_update_sprites)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _update_sprites():
	plot1.hide()
	plot2.hide()
	plot3.hide()
	plot4.hide()
	disp1.hide()
	disp2.hide()
	disp3.hide()
	disp4.hide()

#	xpbar.scale.x = GVars.mushroomData.xp / GVars.mushroomData.xpThresh * 1.5
#	leveldisp.text = "Level: " + str(GVars.getScientific(GVars.mushroomData.level))
#	statsdisp.text = "Buffs\nSpin Buff: " + str(GVars.getScientific(GVars.mushroomData.spinBuff)) + "\nIdentity Buff: " + str(GVars.getScientific(GVars.mushroomData.ascBuff))
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
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] != 0):
			if(n == 0):
				plot1.show()
				plot1.frame = GVars.mushroomData.current[n] - 1
				plot1.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp1.show()
				disp1.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n == 1):
				plot2.show()
				plot2.frame = GVars.mushroomData.current[n] - 1
				plot2.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp2.show()
				disp2.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n == 2):
				plot3.show()
				plot3.frame = GVars.mushroomData.current[n] - 1
				plot3.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp3.show()
				disp3.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n ==3):
				plot4.show()
				plot4.frame = GVars.mushroomData.current[n] - 1
				plot4.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp4.show()
				disp4.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
