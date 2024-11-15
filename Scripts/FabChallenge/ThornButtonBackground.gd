extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.refresh_challenges.connect(self.refresh)
	refresh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refresh():
	if not GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS):
		hide()
