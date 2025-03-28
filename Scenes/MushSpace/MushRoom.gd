extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	updateRots()
	mushbotCheck()
	if(GVars.mushroomData.level >= 10):
		frame = 2

func mushbotCheck():
	if Automation.contains("Mushbot"):
		WheelSpinner.wheelRotationCompleted.connect(updateRots)
		
func updateRots():
	if(GVars.mushroomData.pendingRots < 0):
		GVars.mushroomData.pendingRots = 0
	for n in GVars.mushroomData.current.size():
		GVars.mushroomData.timeLeft[n] -= GVars.mushroomData.pendingRots
		if(GVars.mushroomData.timeLeft[n] <= 0):
			GVars.mushroomData.timeLeft[n] = 0
	GVars.mushroomData.pendingRots = 0
