extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GVars.ifSecondBoot % 4 == 3 or GVars.ifSecondBoot % 4 == 0:
		frame = 0
	else:
		frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
