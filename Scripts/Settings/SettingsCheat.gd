extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_text_submitted(inputtext):
	if(inputtext == "defaultsigilsunlock"):
		GVars.unlock_all_sigils()
		clear()
