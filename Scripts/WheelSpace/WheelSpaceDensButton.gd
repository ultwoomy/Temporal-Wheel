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
@onready var image : Sprite2D = $DensRectDisp
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent

#@ Virtual Methods
func _ready() -> void:
	button.text = str("Condense")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.spinData.density)
	button.pressed.connect(self._onButtonPressed)
	image.scale.x = GVars.spinData.curSucDens/GVars.spinData.densTresh*2
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))


#@ Private Method
#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _onButtonPressed() -> void:
	var playPriority = 0
	if(GVars.spinData.size > GVars.spinData.sucPerTDens):
		GVars.spinData.size -= GVars.spinData.sucPerTDens
		GVars.spinData.curSucDens += GVars.spinData.sucPerTDens
		playPriority = 1
	if(GVars.spinData.curSucDens >= GVars.spinData.densTresh):
		GVars.spinData.density += 1
		densUp.emit()
		growDisplay.text = str(GVars.spinData.density)
		GVars.spinData.curSucDens = 0
		GVars.spinData.densTresh += 1
		GVars.spinData.wheelPhase = int(GVars.spinData.density)
		playPriority = 2
	if playPriority == 1:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.get_child(0).init(load("res://Sound/SFX/z.wav"))
	elif playPriority == 2:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.get_child(0).init(load("res://Sound/SFX/tsu.wav"))
	else:
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.get_child(0).init(load("res://Sound/SFX/nono.wav"))		
	image.scale.x = GVars.spinData.curSucDens/GVars.spinData.densTresh*2
