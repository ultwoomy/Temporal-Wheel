extends Node
class_name MushFarmPlots


#@ Signals
signal mushroomPlanted
signal mushroomHarvested


#@ Onready Variables
@onready var plot1 : AnimatedSprite2D = $Plot1/MushroomSprite1
@onready var plot2 : AnimatedSprite2D = $Plot2/MushroomSprite2
@onready var plot3 : AnimatedSprite2D = $Plot3/MushroomSprite3
@onready var plot4 : AnimatedSprite2D = $Plot4/MushroomSprite4
@onready var disp1 : Label = $Plot1/TimeLeftDisp1
@onready var disp2 : Label = $Plot2/TimeLeftDisp2
@onready var disp3 : Label = $Plot3/TimeLeftDisp3
@onready var disp4 : Label = $Plot4/TimeLeftDisp4


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_sprites()
	mushbotCheck()
	
	get_window().get_node("EventManager").mushroom_planted.connect(_update_sprites)
	get_window().get_node("EventManager").mushroom_harvested.connect(_update_sprites)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func mushbotCheck():
	if Automation.contains("Mushbot"):
		WheelSpinner.wheelRotationCompleted.connect(_update_sprites)


#@ Virtual Methods
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
	for n in GVars.mushroomData.currentFarmPlots.size():
		if GVars.mushroomData.currentFarmPlots[n]:
			if(n == 0):
				plot1.show()
				##
				## TODO: FIX FRAMES
				##
				#plot1.frame = GVars.mushroomData.currentFarmPlots[n] - 1
				plot1.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.currentFarmPlots[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp1.show()
				disp1.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n == 1):
				plot2.show()
				#plot2.frame = GVars.mushroomData.currentFarmPlots[n] - 1
				plot2.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.currentFarmPlots[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp2.show()
				disp2.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n == 2):
				plot3.show()
				#plot3.frame = GVars.mushroomData.currentFarmPlots[n] - 1
				plot3.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.currentFarmPlots[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp3.show()
				disp3.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n ==3):
				plot4.show()
				#plot4.frame = GVars.mushroomData.currentFarmPlots[n] - 1
				plot4.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.currentFarmPlots[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*timeBasedOnType + GVars.mushroomData.level * timeBasedOnLevel)) + 0.01)
				disp4.show()
				disp4.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
