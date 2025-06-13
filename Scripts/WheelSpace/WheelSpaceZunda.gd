extends AnimatedSprite2D


#@ Export Variables
@export var countdownBack : Sprite2D
@export var countdownText : Label
@export var requestButton : TextureButton
@export var upperContractExit : Container


#@ Public Variables
var currentRequest : Request
var requestsDone : int


#@ Onready Variables
@onready var requestLabelScene = preload("res://Scenes/RequestGraphic.tscn")


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	if not GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET):
		hide()
	else:
		WheelSpinner.wheelRotationCompleted.connect(updateCounter)
		upperContractExit.exitUpperContract.connect(quitContract)
		resetRequest()
		updateCounter()


#@ Public Methods
func updateCounter():
	GVars.nightChallengeData.hungerCurrent += 1
	if GVars.nightChallengeData.extraHungry:
		currentRequest.upImpatience()
		currentRequest.upImpatience()
	currentRequest.upImpatience()
	countdownText.text = str(GVars.nightChallengeData.hungerLimit - GVars.nightChallengeData.hungerCurrent - GVars.nightChallengeData.hungerDeduction)
	if GVars.nightChallengeData.hungerLimit - GVars.nightChallengeData.hungerCurrent - GVars.nightChallengeData.hungerDeduction < 0:
		#losing sequence temporarily just adds an extra request instead of killing you
		GVars.nightChallengeData.hungerCurrent = 0
		#SceneHandler.changeSceneToFilePath(SceneHandler.NIGHT_LOSS)
	elif GVars.nightChallengeData.hungerLimit - GVars.nightChallengeData.hungerCurrent - GVars.nightChallengeData.hungerDeduction < 20:
		countdownBack.self_modulate = Color.DARK_RED


func resetRequest():
	requestsDone = 0
	for i in GVars.nightChallengeData.requestList:
		if not i.finished:
			currentRequest = i
			break
		requestsDone += 1
	if requestsDone == 9:
		#winning sequence		
		GVars.hellChallengeLayer2 = -1
		GVars.hellChallengeNerf = -1
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 20
		quitContract()
	countdownBack.self_modulate = Color.AQUA
	var instance = requestLabelScene.instantiate()
	requestButton.add_child(instance)
	if requestsDone > 4:
		GVars.nightChallengeData.extraHungry = true
	#requestButton.get_child(0).position = Vector2(30,-200)


func _on_texture_button_pressed():
	if currentRequest.checkPassing():
		currentRequest.finished = true
		GVars.nightChallengeData.hungerCurrent = 0
		requestButton.get_child(0).queue_free()
		resetRequest()


func quitContract():
	WheelSpinner.wheelRotationCompleted.disconnect(updateCounter)
	GVars.nightChallengeData.resetData()
	hide()
