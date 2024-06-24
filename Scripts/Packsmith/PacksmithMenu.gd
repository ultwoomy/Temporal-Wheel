extends Control
class_name PacksmithMenu


#@ Enumerators
enum Emotes {
	PEEK,
	PEEKEYEBROW,
	NORMAL,
	TALKING,
	EYEBROW,
	CONCERN,
}


#@ Export Variables


#@ Public Variables
var currentState : PS_MenuState = PS_MenuPickState.new(self)  # We start in the pick state menu, and give it a reference to this node/script.



#@ Private Variable
var _dialogueHandler : DialogueHandler = DialogueHandler.new()  # Ignore warning, it does get used by PacksmithMenuTalkState.


#@ Onready Variables
@onready var inspectButton : Button = $InspectButton
@onready var augmentButton : Button = $AugmentButton
@onready var upgradeButton : Button = $UpgradeButton
@onready var automateButton : Button = $AutomateButton
@onready var nextButton 	: Button = $NextButton
@export var dialogueText : Label  # L.B - WIP: Remove from Packsmith (OUTSIDE PacksmithMenu)

@onready var selectionMenu : SelectionMenu = $SelectionMenu
@onready var upgradeMenu : UpgradeMenu = $UpgradeMenu
@onready var automationMenu : AutomationMenu = $AutomationMenu


@export var packback : AnimatedSprite2D  # L.B - WIP: Remove from Packsmith (OUTSIDE PacksmithMenu)


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Run current state's enter, since it is the first state which isn't ran in changeState().
	currentState._enter()
	upgradeMenu.hide()
	
	
	
	if (GVars.hellChallengeNerf > 0) or (GVars.ifhell):
		automateButton.show()
	else:
		automateButton.hide()
	automationMenu.hide()
	
	nextButton.hide()
	
	if not GVars.sigilData.numberOfSigils[0]:
		inspectButton.hide()
		augmentButton.hide()
		upgradeButton.hide()
		automateButton.hide()
		dialogueText.text = "No shirt, no sigil, no service."
	
	
	selectionMenu.hide()


func _process(delta: float) -> void:
	# currentState's _update() function should be called every frame to act like _process().
	if currentState:
		currentState._update(delta)


#@ Public Methods
func changeState(newState : PS_MenuState) -> void:
	# Call currentState's exit function before changing it.
	if currentState:
		currentState._exit()
	
	# Change currentState to newState w/ the same init variables, and call its enter function.
	currentState = newState
	currentState._enter()
