extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GVars.ifsecondboot % 4 == 3 or GVars.ifsecondboot % 4 == 0:
		frame = 0
	else:
		frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
