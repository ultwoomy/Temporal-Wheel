extends CharacterBody2D
@export var back : Button
@export var forward : Button
@export var statDisplay : Label
@export var everythingelse : Control
var rotSpeed = 0.001
var eSeq = false
var frames = 0.00
# Called when the node enters the scene tree for the first time.
func _ready():
	update_wheel_sprite(GVars.density - 1)
	back.pressed.connect(self._wheel_scene)
	forward.text = "Proceed"
	forward.pressed.connect(self._end_sequence)
	var dis = "Current Presence: " + str(GVars.getScientific(GVars.Aspinbuff)) + "\nNext Presence: " + str(GVars.getScientific(GVars.mushroomData.ascBuff) + GVars.getScientific(GVars.ritualData.ascBuff))
	dis += "\n\nThe highest presence\nvalue is kept."
	if(GVars.sigilData.curSigilBuff == 4):
		dis += "\n\nYou have worn the\nface of myraid emotion."
	statDisplay.text = dis

func update_wheel_sprite(frameno):
	if(frameno > 11):
		self.get_node("Centerpiece").frame = 11
	else :
		self.get_node("Centerpiece").frame = frameno
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation += rotSpeed
	if(eSeq):
		rotSpeed += 0.0005
		if(frames < 750):
			frames += 1
		else: 
			get_tree().change_scene_to_file("res://Scenes/AscensionSpace.tscn")
		scale = Vector2(pow(1 + rotSpeed*frames/30,2),pow(1 + rotSpeed*frames/30,2))
		if(frames > 650):
			modulate = Color((1-(frames-650)/100),(1-(frames-650)/100),(1-(frames-650)/100))

func _wheel_scene():
	var event_manager = get_tree().get_root().find_child("EventManager", true, false)
	event_manager.emit_signal("scene_change",true)
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")

func _end_sequence():
	everythingelse.hide()
	eSeq = true
