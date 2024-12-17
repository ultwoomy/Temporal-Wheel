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
			 "Let's wait for size level 3"]
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
	EventManager.tutorial_grow_found.connect(self.introduceSelf)
	EventManager.tutorial_grow_clicked.connect(self.growClicked)
	WheelSpinner.wheelRotationCompleted.connect(self.fullRotation)
	if GVars.ifFirstBoot and GVars.sigilData.acquiredSigils.is_empty():
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
	if GVars.spinData.curSucSize > 0:
		phase = 2
		_on_text_bubble_pressed()
	else:
		text.text = "Press Grow to toggle it on"
		phase = 1

func growClicked():
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
	elif phase == 3:
		return true
	elif phase == 4:
		return true
	elif phase == 5:
		return true
	elif phase == 6:
		return GVars.spinData.size > 2
	return false
