extends Node
class_name MMushInfoPanel


## Components
@onready var currentMush : AnimatedSprite2D = $CurrentMush
@onready var desc : Label = $MushDescription
@onready var left : Button = $LeftArrow
@onready var right : Button = $RightArrow


## Variables
var currentFrame : int



## Functions
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentMush.frame = 0
	desc.size = Vector2(216,90)
	desc.position = Vector2(90,350)
	currentFrame = 0
	_setdesc()
	
	# Listeners
	left.pressed.connect(self._left)
	right.pressed.connect(self._right)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _left() -> void:
	if(currentFrame <= 0):
		currentFrame = 3
	else:
		currentFrame -= 1
	_setdesc()
	currentMush.frame = currentFrame
	get_window().get_node("EventManager").mushroom_frame_changed.emit(currentFrame)


func _right() -> void:
	if(currentFrame >= 3):
		currentFrame = 0
	else:
		currentFrame += 1
	_setdesc()
	currentMush.frame = currentFrame
	get_window().get_node("EventManager").mushroom_frame_changed.emit(currentFrame)


func _setdesc() -> void:
	var descriptions: Array[String] = [
		"Lamp Shroom\nLights up your day.\nGives you momentum.",
		"Rot Shroom\nThey are tight knit friends.\nGives you rotations.",
		"Wine Shroom\nA lot of fun at parties.\nGives you a momentum bonus.",
		"Twin Shroom\nWhispers to you.\nGives you a identity bonus.",
	]
	
	# Check to see if currentFrame is in bounds.
	if (currentFrame >= 0 && currentFrame < descriptions.size()):
		desc.text = descriptions[currentFrame]
	else:
		desc.text = ""