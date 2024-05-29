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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if not backShow:
		back.show()
		backShow = true
	else:
		back.hide()
		backShow = false
