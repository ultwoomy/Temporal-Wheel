extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	initAch()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	for i in self.get_children():
		i.queue_free()
	initAch()
	
func initAch():
	var n : int = 0
	var max : int = 7
	GVars.dollarData = DollarData.new()
	for i in GVars.dollarData.achievementList:
		if not i.filled and n < max:
			var sf = load("res://Scenes/AchievementScene.tscn").instantiate()
			self.add_child(sf)
			sf.setAch(i)
			sf.position = Vector2(0,100 * n)
			sf.achievementButtonPressed.connect(self.update)
			n += 1
