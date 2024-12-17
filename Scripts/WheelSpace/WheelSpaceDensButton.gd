extends Control
class_name WheelSpaceDensityButton


#@ Signals
signal densUp


#@ Export Variables


#@ Public Variables
var ifsucc = false


#@ Onready Variables
@onready var growDisplay : Label = $DensDisplay
@onready var button : Button = $DensToggle
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent

#@ Virtual Methods
func _ready() -> void:
	button.text = str("Condense")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.spinData.density)
	button.pressed.connect(self._onButtonPressed)
	if GVars.ifFirstBoot and GVars.sigilData.acquiredSigils.is_empty() and GVars.spinData.size < 2:
		hide()


#@ Private Method
#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _onButtonPressed() -> void:
	var playPriority = 0
	if(GVars.spinData.size >= GVars.spinData.densTresh + 1):
		GVars.spinData.density += 1
		GVars.spinData.size -= GVars.spinData.densTresh
		densUp.emit()
		growDisplay.text = str(GVars.spinData.density)
		GVars.spinData.densTresh += 1
		GVars.spinData.wheelPhase = int(GVars.spinData.density)
		playPriority = 2
	elif playPriority == 2:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.get_child(0).init(load("res://Sound/SFX/tsu.wav"))
	else:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.get_child(0).init(load("res://Sound/SFX/nono.wav"))		
