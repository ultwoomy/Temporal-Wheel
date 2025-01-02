extends Container
@onready var left : TextureButton = $Left
@onready var right : TextureButton = $Right
@onready var back : Sprite2D = $Back
@onready var sigil : AnimatedSprite2D = $SongSigil
@onready var text : Label = $Title

# Called when the node enters the scene tree for the first time.
func _ready():
	left.position = Vector2(-40,30)
	right.position = Vector2(230,30)
	text.position = Vector2(95,-20)
	right.scale = Vector2(0.7,0.7)
	left.scale = Vector2(0.7,0.7)
	checkCurrentTrack()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_left_pressed():
	pass # Replace with function body.


func _on_right_pressed():
	pass # Replace with function body.

func checkCurrentTrack():
	if GVars.currentTrack == 0:
		text.text = "MKD20"
	elif GVars.currentTrack == 1:
		text.text = "SL40"
