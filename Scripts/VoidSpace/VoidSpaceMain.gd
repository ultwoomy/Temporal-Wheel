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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentState:
		currentState._update(delta)


#@ Public Methods
func changeState(newState : VS_MenuState) -> void:
	if currentState:
		currentState._exit()
	currentState = newState
	currentState._enter()


func unlockRitualButton() -> void:
	if(GVars.sigilData.numberOfSigils[4]):
		ritualButton.show()
	else:
		ritualButton.hide()

func unlockKbityButton() -> void:
	if GVars.kbityData.kbityLevel > 0:
		kbityButton.show()
	else:
		kbityButton.hide()
