extends TextureButton
@export var back : Panel
var backShow : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	back.hide()
	if GVars.backpackData.cheese:
		show()
		back.hide()


func _on_pressed():
	if not backShow:
		back.show()
		backShow = true
	else:
		back.hide()
		backShow = false
