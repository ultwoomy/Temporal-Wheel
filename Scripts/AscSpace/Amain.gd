extends AnimatedSprite2D
@export var dia : Label
@export var fear : Button
@export var cold : Button
@export var warmth : Button
@export var wrath : Button
@export var complacent : Button
@export var awaken : Button
var line
var frames = 0.00
# Called when the node enters the scene tree for the first time.
func _ready():
	_hide_all()
	fear.pressed.connect(self._butF)
	cold.pressed.connect(self._butC)
	warmth.pressed.connect(self._butW)
	wrath.pressed.connect(self._butWrath)
	complacent.pressed.connect(self._butComp)
	awaken.pressed.connect(self._awaken)
	frames = 0.00
	await get_tree().create_timer(2).timeout
	dia.text = "You find yourself\nat an endless ocean."
	GVars._dialouge(dia,0,0.05)
	dia.text += "\n\nIt calls to you."
	dia.text += "\n\nYou feel..."
	await get_tree().create_timer(4.5).timeout
	if(GVars.curSigilBuff == 3):
		fear.show()
		cold.show()
		warmth.show()
		wrath.show()
	complacent.show()

func _butF():
	pass
	
func _butC():
	pass

func _butW():
	pass
	
func _butWrath():
	pass
	
func _butComp():
	_hide_all()
	dia.text = dia.text.left(dia.text.length() - 7)
	dia.text += "feel nothing.\n\nYou sink willingly\ninto the deep."
	GVars._dialouge(dia,62,0.05)
	await get_tree().create_timer(3).timeout
	awaken.show()
	
func _awaken():
	GVars.Aspinbuff = GVars.Sascbuff
	GVars.resetR0Stats()
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
	
func _hide_all():
	fear.hide()
	cold.hide()
	warmth.hide()
	wrath.hide()
	complacent.hide()
	awaken.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(frames < 200):
		frames += 1
		modulate = Color(frames/200,frames/200,frames/200)
