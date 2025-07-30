extends GameButton
class_name WheelSpaceGrowButton


#@ Signals
signal toggled(on : bool)


#@ Constants
const RED_COLOR : Color = Color(0.93, 0.11, 0.14)
const GREEN_COLOR : Color = Color(0.04, 0.4, 0.14)


#@ Export Variables



#@ Public Variables
var growing : bool = false


#@ Onready Variables
@onready var growSizeLabel : Label = $GrowDisplay
@onready var button : Button = $VBoxContainer/GrowButtonContainer/ToggleGrowButton
@onready var toggleLabel : Label = $VBoxContainer/GrowButtonContainer/ToggleGrowButton/ToggleLabel

@onready var growToggleRect : ColorRect = $VBoxContainer/GrowRectContainer/GrowRectDisplay
@onready var growToggleRectContainer : PanelContainer = $VBoxContainer/GrowRectContainer
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent


#@ Virtual Methods
func _ready():
	#Yu: Every time one rotation finishes, growth will trigger once. Changed from once per second.
	#    Threshold and threshold multiplier for size reduced accordingly
	
	# Connecting Signals.
	button.pressed.connect(self._buttonPressed)
	#EventManager.wheel_spun.connect(self.checkTutorial)
	WheelSpinner.wheelRotationCompleted.connect(self.grow)
	growToggleRectContainer.sort_children.connect(_onChildSorted)  # Needed to resize the ColorRect.
	
	growing = GVars.spinData.sizeToggle
	
	growSizeLabel.text = str(GVars.spinData.size)
	
	_showToggleIndicators(growing)


#@ Public Methods
func grow() -> void:
	# Local Variables.
	var suc : float = 0.0;
	var Ebuff = 0;
	var rustUpBuff = GVars.rustData.increaseHunger
	
	if GVars.curEmotionBuff == 4:
		rustUpBuff = rustUpBuff * GVars.rustData.fourth
	if GVars.curEmotionBuff == 2:
		Ebuff = (GVars.rustData.fourth - 1) * GVars.spinData.sucTresh
	
	if GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_ASCENSION:
		suc = GVars.spinData.sucPerTick * rustUpBuff * GVars.spinData.sizeRecord + Ebuff
	else:
		suc = GVars.spinData.sucPerTick * rustUpBuff + Ebuff
	
	if growing:
		if(GVars.spinData.momentum >= suc):
			_displayIncrementValue(-suc)
			GVars.spinData.momentum -= suc
			GVars.spinData.curSucSize += suc
			if(GVars.spinData.curSucSize >= GVars.spinData.sucTresh):
				GVars.spinData.size += 1
				if(GVars.spinData.size > GVars.spinData.sizeRecord):
					GVars.spinData.sizeRecord = GVars.spinData.size
				growSizeLabel.text = str(GVars.spinData.size)
				GVars.spinData.curSucSize = 0
				GVars.spinData.sucTresh *= 3
	growToggleRect.size.x = GVars.spinData.curSucSize/GVars.spinData.sucTresh * 2 * 100


#@ Private Methods
func _buttonPressed() -> void:
	playAnimation(GameButtonPopAnimation.new(self))
	if growing:
		growing = false
		GVars.spinData.sizeToggle = false		
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.start(load("res://Sound/SFX/nono.wav"))
		toggled.emit(false)
	else:
		growing = true
		GVars.spinData.sizeToggle = true
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.start(load("res://Sound/SFX/yes.wav"))
		toggled.emit(true)
	_showToggleIndicators(growing)


# When the container(s) have finished resizing.
func _onChildSorted() -> void:
	# Resize the color rect after resorting the container.
	growToggleRect.size.x = GVars.spinData.curSucSize/GVars.spinData.sucTresh * 2 * 100


func _displayIncrementValue(value : float) -> void:
	var incrementLabel : IncrementLabel = createIncrementLabel(value)
	incrementLabel.position = self.position + Vector2(self.size.x/2.0, self.size.y/2.0) - (incrementLabel.size / 2.0)


func _showToggleIndicators(on : bool) -> void:
	if on:
		growToggleRect.color = GREEN_COLOR
		toggleLabel.add_theme_color_override("font_color", GREEN_COLOR)
		toggleLabel.text = "ON"
	else:
		growToggleRect.color = RED_COLOR
		toggleLabel.add_theme_color_override("font_color", RED_COLOR)
		toggleLabel.text = "OFF"
