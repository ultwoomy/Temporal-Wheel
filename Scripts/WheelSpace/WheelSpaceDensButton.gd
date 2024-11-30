extends GameButton
class_name WheelSpaceDensityButton


#@ Signals
signal densUp


#@ Export Variables


#@ Public Variables
var ifsucc = false


#@ Onready Variables
@onready var densityDisplay : Label = $DensDisplay
@onready var button : Button = $VBoxContainer/DensityButtonContainer/DensityButton
@onready var image : Sprite2D = $DensRectDisp
@onready var densityGauge : ColorRect = $VBoxContainer/DensityGaugeContainer/DensityGaugeDisplay
@onready var densityGaugeContainer : PanelContainer = $VBoxContainer/DensityGaugeContainer
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent


#@ Virtual Methods
func _ready() -> void:
	# Connecting Signals.
	button.pressed.connect(self._onButtonPressed)
	densityGaugeContainer.sort_children.connect(_onChildSorted)  # For resizing the gauge meter when starting the scene
	
	densityDisplay.text = str(GVars.spinData.density)


#@ Private Method
#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _onButtonPressed() -> void:
	playAnimation(GameButtonPopAnimation.new(self))
	var playPriority = 0
	if(GVars.spinData.size > GVars.spinData.sucPerTDens):
		GVars.spinData.size -= GVars.spinData.sucPerTDens
		GVars.spinData.curSucDens += GVars.spinData.sucPerTDens
		playPriority = 1
	if(GVars.spinData.curSucDens >= GVars.spinData.densTresh):
		GVars.spinData.density += 1
		densUp.emit()
		densityDisplay.text = str(GVars.spinData.density)
		GVars.spinData.curSucDens = 0
		GVars.spinData.densTresh += 1
		GVars.spinData.wheelPhase = int(GVars.spinData.density)
		playPriority = 2
	if playPriority == 1:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.start(load("res://Sound/SFX/z.wav"))
	elif playPriority == 2:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.start(load("res://Sound/SFX/tsu.wav"))
	else:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.start(load("res://Sound/SFX/nono.wav"))		
	densityGauge.size.x = GVars.spinData.curSucDens/GVars.spinData.densTresh * 2 * 100


# When the container(s) have finished resizing.
func _onChildSorted() -> void:
	# Resize the density gauge after resorting.
	densityGauge.size.x = GVars.spinData.curSucDens/GVars.spinData.densTresh * 2 * 100
