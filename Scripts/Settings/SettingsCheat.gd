extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_text_submitted(inputtext):
	if(inputtext == "freecrap"):
		GVars.spinData.spin = 1000000000000
		GVars.spinData.rotations = 10000000
		clear()
	if(inputtext == "brilliantlightningrush"):
		GVars.rustData.rust = 1000000000
		clear()
	if(inputtext == "finishr2contracts"):
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.doubleShroomChanceEnabled = true
		clear()
	if(inputtext == "resethelltext"):
		GVars.ifFirstHell = true
		clear()
	if(inputtext == "givemesouls"):
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 200
		GVars.ifhell = true
		clear()
	if(inputtext == "hellmewhy"):
		GVars.ifhell = true
		clear()
	if(inputtext == "impoor"):
		GVars.spinData.spin = 0
		GVars.spinData.rotations = 0
		clear()
	if(inputtext == "sans"):
		GVars.sand = 1000
		clear()
	if(inputtext == "accel"):
		GVars.Aspinbuff = 100
		clear()
