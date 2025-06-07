extends GameButton
class_name WheelSpaceGrowButton


#@ Constants



#@ Export Variables
@export var growDisplay: Label
@export var button : Button
@onready var growToggleRect : ColorRect = $VBoxContainer/GrowRectContainer/GrowRectDisplay
@onready var growToggleRectContainer : PanelContainer = $VBoxContainer/GrowRectContainer
@export var spinbody: CharacterBody2D
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent


#@ Public Variables
var ifsucc = false


#@ Virtual Methods
func _ready():
	#Yu: Every time one rotation finishes, succ will trigger once. Changed from once per second.
	#    Threshold and threshold multiplier for size reduced accordingly
	
	# Connecting Signals.
	button.pressed.connect(self._buttonPressed)
	EventManager.wheel_spun.connect(self.checkTutorial)
	WheelSpinner.wheelRotationCompleted.connect(self.suc_loop)
	growToggleRectContainer.sort_children.connect(_onChildSorted)  # Needed to resize the ColorRect.
	
	if GVars.spinData.sizeToggle:
		ifsucc = true
	
	growDisplay.text = str(GVars.spinData.size)
	
	if ifsucc:
		growToggleRect.color = Color(0.04, 0.4, 0.14)  # GREEN
	else :
		growToggleRect.color = Color(0.93, 0.11, 0.14)  # RED
	if GVars.ifFirstBoot and GVars.sigilData.acquiredSigils.is_empty() and GVars.spinData.momentum <= 50:
		hide()
		growToggleRect.color = Color(0.93, 0.11, 0.14)  # RED


#@ Public Methods
func suc_loop():
	# Local Variables.
	var suc = 0.0;
	var Ebuff = 0;
	var rustUpBuff = GVars.rustData.increaseHunger
	
	if(GVars.curEmotionBuff == 4):
		rustUpBuff = rustUpBuff * GVars.rustData.fourth
	if(GVars.curEmotionBuff == 2):
		Ebuff = (GVars.rustData.fourth - 1) * GVars.spinData.sucTresh
	if(GVars.sigilData.curSigilBuff == 2):
		suc = GVars.spinData.sucPerTick * rustUpBuff * GVars.spinData.sizeRecord + Ebuff
	else:
		suc = GVars.spinData.sucPerTick * rustUpBuff + Ebuff
	if(ifsucc):
		if(GVars.spinData.momentum >= suc):
			_displayIncrementValue(-suc)
			GVars.spinData.momentum -= suc
			GVars.spinData.curSucSize += suc
			if(GVars.spinData.curSucSize >= GVars.spinData.sucTresh):
				GVars.spinData.size += 1
				if GVars.ifFirstBoot and GVars.sigilData.acquiredSigils.is_empty() and GVars.spinData.size == 3:
					EventManager.tutorial_dens_found.emit()
				if(GVars.spinData.size > GVars.spinData.sizeRecord):
					GVars.spinData.sizeRecord = GVars.spinData.size
				growDisplay.text = str(GVars.spinData.size)
				GVars.spinData.curSucSize = 0
				GVars.spinData.sucTresh *= 3
	growToggleRect.size.x = GVars.spinData.curSucSize/GVars.spinData.sucTresh * 2 * 100


func checkTutorial():
	if GVars.spinData.momentum >= 50:
		show()
		EventManager.wheel_spun.disconnect(self.checkTutorial)
		EventManager.tutorial_grow_found.emit()


#@ Private Methods
func _buttonPressed():
	EventManager.tutorial_grow_clicked.emit()
	playAnimation(GameButtonPopAnimation.new(self))
	if ifsucc:
		ifsucc = false
		GVars.spinData.sizeToggle = false
		growToggleRect.color = Color(0.93, 0.11, 0.14)  # RED
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.start(load("res://Sound/SFX/nono.wav"))
	else :
		ifsucc = true
		GVars.spinData.sizeToggle = true
		growToggleRect.color = Color(0.04, 0.4, 0.14)  # GREEN
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.start(load("res://Sound/SFX/yes.wav"))


# When the container(s) have finished resizing.
func _onChildSorted() -> void:
	# Resize the color rect after resorting the container.
	growToggleRect.size.x = GVars.spinData.curSucSize/GVars.spinData.sucTresh * 2 * 100


func _displayIncrementValue(value : float) -> void:
	var incrementLabel : IncrementLabel = createIncrementLabel(value)
	incrementLabel.position = self.position + Vector2(self.size.x/2.0, self.size.y/2.0) - (incrementLabel.size / 2.0)
