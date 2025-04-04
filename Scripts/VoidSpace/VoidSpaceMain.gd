extends GameScene
class_name VoidSpaceMain


#@ Public Variables
var currentState : VS_MenuState


#@ Onready Variables
@onready var busStopBackground : Sprite2D = $BusStopBackground

@onready var sigilButton : Button = $SigilButton  # Use to enter the sigil shop.
@onready var sigilShop : Container = $SigilShop
@onready var ritualButton : Button = $RitualButton  # Use to enter the ritual shop.
@onready var ritualShop : Container = $RitualShop
@onready var kbityButton : Button = $KbityCloneButton # Enter kbity shop
@onready var kbityShop : Panel = $KbityShop

@onready var backButton : Button = $BackButton

var bb = load("res://Scenes/BleedBar.tscn").instantiate()
@onready var challengeManager : ChallengeManager = $ChallengeManager


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize and set state.
	var initialState : VS_MenuState = VS_MenuPickState.new(self)
	changeState(initialState)
	
	# Hide the shops.
	sigilShop.hide()
	ritualShop.hide()
	kbityShop.hide()
	
	# Either hides or shows ritual button.
	unlockRitualButton()
#	ritualButton.show()  # Testing purposes.
	if(GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS)):
		self.add_child(bb)
	checkBleedBar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentState:
		currentState._update(delta)


#@ Public Methods
func checkBleedBar():
	if not GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS):
		bb.queue_free()


func changeState(newState : VS_MenuState) -> void:
	if currentState:
		currentState._exit()
	currentState = newState
	currentState._enter()


func unlockRitualButton() -> void:
	const ritualSigil : Sigil = preload("res://Resources/Sigil/RitualSigil.tres")
	ritualButton.visible = GVars.sigilData.acquiredSigils.has(ritualSigil)


func unlockKbityButton() -> void:
	kbityButton.visible = GVars.kbityData.kbityLevel > 0
