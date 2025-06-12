extends GameScene


#@ Public Variables


#@ Onready Variables
@onready var controlUI : Control = $Control
@onready var backButton : Button = $Control/Back
@onready var ascendButton : Button = $Control/Ascend
@onready var statDisplay : Label = $"Control/Stat Display"
@onready var confirmationPanel : Panel = $Confirmation
@onready var centerpiece : AnimatedSprite2D = $Centerpiece


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals.
	backButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.WHEELSPACE))  # Change scene to WHEELSPACE when back button is pressed.
	ascendButton.pressed.connect(self._endSequence)
	confirmationPanel.confirmed.connect(centerpiece.setEndSequence.bind(true))
	confirmationPanel.canceled.connect(controlUI.show)
	
	# Visuals.
	displayStatistics()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func displayStatistics() -> void:
	var sandsigil = load("res://Sprites/Sigils/sigil10.png")
	var textToBeDisplayed : String = "Current Presence: " + str(GVars.getScientific(GVars.Aspinbuff)) + "\n"
	textToBeDisplayed += "Next Presence: " + str(GVars.getScientific(GVars.mushroomData.ascBuff))
	textToBeDisplayed += " + "
	textToBeDisplayed += str(GVars.getScientific(GVars.ritualData.ascBuff))
	if sandsigil in GVars.sigilData.acquiredSigils:
		textToBeDisplayed += " + " + str(GVars.getScientific(pow(GVars.dollarData.sandDollars,2))) + "\n\n"
	else:
		textToBeDisplayed += "\n\n"
	textToBeDisplayed += "The highest presence\nvalue is kept.\n\n"
	if GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_EMPTINESS:
		textToBeDisplayed += "You have worn the\nface of myraid emotion."
	
	statDisplay.text = textToBeDisplayed


#@ Private Methods
func _endSequence() -> void:
	#hides every ui element before playing reset animation
	controlUI.hide()
	if not GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_EMPTINESS and GVars.SIGIL_EMPTINESS in GVars.sigilData.acquiredSigils:
		confirmationPanel.show()
	else:
		centerpiece.setEndSequence(true)
