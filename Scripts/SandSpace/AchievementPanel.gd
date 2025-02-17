extends Panel
signal achievementCompleted

# Called when the node enters the scene tree for the first time.
func _ready():
	initAch()

	
func initAch():
	var n : int = 0
	var max : int = 7
	for i in GVars.dollarData.achievementList:
		if not i.filled and n < max:
			var sf = load("res://Scenes/AchievementScene.tscn").instantiate()
			self.add_child(sf)
			sf.setAch(i)
			sf.position = Vector2(0,100 * n)
			sf.achievementButtonPressed.connect(self.checkoff)
			n += 1

func refresh():
	for i in self.get_children():
		i.queue_free()
	initAch()
	
func checkoff(ach):
	var n : int
	for i in GVars.dollarData.achievementList:
		if i.achievementName == ach.achievementName:
			i.filled = true
			GVars.dollarData.sandDollars += i.rewardDollars
			GVars.dollarData.achievementsCompleted += 1
			emit_signal("achievementCompleted")
		n += 1
	refresh()


func _on_back_button_pressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)
