extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_text_submitted(inputtext):
	if(inputtext == "defaultsigilsunlock"):
		GVars.unlock_all_sigils()
		clear()
	if(inputtext == "freecrap"):
		GVars.spinData.spin = 1000000000000
		GVars.spinData.rotations = 1000000
	if(inputtext == "brilliantlightningrush"):
		GVars.rustData.rut = 1000000000
