extends AnimatedSprite2D
var nextPanel = 1
var nextFrame : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	frame = 0
	animate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(position.x,position.y + cos(nextFrame/60)/2)
	nextFrame += 1

func animate():
	await get_tree().create_timer(1).timeout
	frame = nextPanel
	nextPanel += 1
	if nextPanel > 5:
		nextPanel = 0
	animate()

func goBack():
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)
