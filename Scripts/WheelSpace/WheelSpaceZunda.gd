extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not GVars.hellChallengeLayer2 == 2:
		hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
