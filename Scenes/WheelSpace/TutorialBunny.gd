extends Container
var frame = 0
var changex = -1
var changey = 1
var startMoving : bool
var finalPos = Vector2(650,520)
var phase = 0
var ifFirstGrowPress = true
var lines = ["", "", "", "Grow absorbs momentum to increase size",
			 "Each level of size takes more momentum",
			 "Momentum gain is multiplied by size",
			 "Click again when you have 3 size",
			 "Density costs 1 more size than its current value",
			 "But you can't have 0 size, so you'll need 3",
			 "Would you look at that, you have 3 size!",
			 "Pressing condense will increase the wheel's density",
			 "Each level of density makes the wheel spin faster", 
			 "It's almost time for us to part",
			 "You've pressed Condense right?",
			 "Press Travel and head to Voidspace",
			 "I'll tell ya the rest there"]
@onready var bun : Sprite2D = $Bun
@onready var textBubble : TextureButton = $Sprite2D
@onready var text : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	bun.hide()
	textBubble.hide()
	textBubble.position = Vector2(-170,-120)
	textBubble.scale = Vector2(0.55,0.55)
	text.hide()
	text.position = Vector2(-160,-105)
	text.size = Vector2(150,100)
	startMoving = false
	bun.position = Vector2(11,40)
	if GVars.ifFirstBoot:
		print("huh")
		EventManager.tutorial_grow_found.connect(self.introduceSelf)
		EventManager.tutorial_grow_clicked.connect(self.growClicked)
		WheelSpinner.wheelRotationCompleted.connect(self.fullRotation)
		if GVars.spinData.spin > 49:
			EventManager.tutorial_grow_found.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if startMoving:
		position = Vector2(position.x + changex,position.y + changey)
		changey += 1/58
		if position.y > finalPos.y or position.x < finalPos.x:
			startMoving = false
			bubbleOne()
	if phase == 1 and not GVars.spinData.sizeToggle and not ifFirstGrowPress:
		text.text = "You just toggled it off, click Grow again"
	elif phase == 1 and GVars.spinData.sizeToggle and not ifFirstGrowPress:
		text.text = "Now wait for a full wheel rotation"
			
func introduceSelf():
	bun.show()
	startMoving = true
	
func bubbleOne():
	text.show()
	textBubble.show()
	if GVars.spinData.density > 1:
		phase = 13
		_on_text_bubble_pressed()
	elif GVars.spinData.size > 2:
		phase = 6
		_on_text_bubble_pressed()
	elif GVars.spinData.size > 1:
		phase = 5
		_on_text_bubble_pressed()
	elif GVars.spinData.curSucSize > 0:
		phase = 2
		_on_text_bubble_pressed()
	else:
		text.text = "Hellos! Press grow to toggle it on"
		phase = 1

func growClicked():
	if phase < 2:
		text.text = "Now we wait for a full wheel rotation"
		ifFirstGrowPress = false
	
func fullRotation():
	if phase == 1:
		text.text = "(Click bubble to advance dialogue)"
		phase += 1


func _on_text_bubble_pressed():
	if phase >= 2:
		if nextPhaseCondition():
			phase += 1
		text.text = lines[phase]
		

func nextPhaseCondition() -> bool:
	if phase == 2:
		return true
	elif phase >= 3 and phase <= 5:
		return true
	elif phase == 6:
		return GVars.spinData.size > 2
	elif phase >= 7 and phase <= 12:
		return true
	elif phase == 13:
		return GVars.spinData.density >= 2
	elif phase == 14:
		return true
	return false
