extends AnimatedSprite2D
@export var frontscreen : Sprite2D
@export var frontscreenLabel : Label
var frames = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_(delta):
	if frames > 0 and frames < 200:
		frames += 1
		modulate = Color(frames/200,frames/200,frames/200)
