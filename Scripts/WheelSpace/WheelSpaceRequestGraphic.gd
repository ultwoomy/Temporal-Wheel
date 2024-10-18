extends Control
@onready var icon : AnimatedSprite2D = $RequestIcon
@onready var text : Label = $Label
@onready var icon2 : AnimatedSprite2D = $RequestIcon2
@onready var text2 : Label = $Label2
var currentRequest : Request

# Called when the node enters the scene tree for the first time.
func _ready():
	updateVars()
	WheelSpinner.wheelRotationCompleted.connect(updateVars)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func updateVars():
	for i in GVars.nightChallengeData.requestList:
		if not i.finished:
			currentRequest = i
			break
	if currentRequest.getPrimaryType() == "momentum":
		icon.frame = 0
		text.text = str(GVars.getScientific(currentRequest.amount))
	elif currentRequest.getPrimaryType() == "rotations":
		icon.frame = 1
		text.text = str(GVars.getScientific(currentRequest.amount))
	elif currentRequest.getPrimaryType() == "cheese":
		icon.frame = 2
		icon2.scale = Vector2(2,2)
		text.hide()
	else: 
		icon.hide()
		text.hide()
	if currentRequest.getSecondaryType() == "momentum" and currentRequest.secondaryTypeEnabled:
		icon2.frame = 0
		text2.text = str(GVars.getScientific(currentRequest.secondaryAmount))
	elif currentRequest.getSecondaryType() == "rotations" and currentRequest.secondaryTypeEnabled:
		icon2.frame = 1
		text2.text = str(GVars.getScientific(currentRequest.secondaryAmount))
	elif currentRequest.getSecondaryType() == "cheese" and currentRequest.secondaryTypeEnabled:
		icon2.frame = 2
		icon2.scale = Vector2(2,2)
		text2.hide()
	else: 
		icon2.hide()
		text2.hide()
