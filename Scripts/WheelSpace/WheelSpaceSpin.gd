extends Node

@export var spinPerCDisplay: Label


@export var button : Button
@export var spinbody : CharacterBody2D
@export var changepreasc : Button
var fmat = preload("res://Scripts/FormatNo.gd")


func _ready():
	save_loop()
	
	spin_update_loop()
	button.size = Vector2(200,100)
	button.text = "Spin"
	button.expand_icon = true

	button.pressed.connect(self._button_pressed)
	spinbody.oneClick.connect(_button_pressed)
	changepreasc.pressed.connect(self._changetopreasc)


func _button_pressed():
	GVars.spin += GVars.spinPerClick * GVars.size * GVars.density * GVars.Rincreasespin * GVars.Sspinbuff
#	L.B: This line of code is being commented out since it isn't needed (since SpinDisplay has it in its _process() function)
#	...If you want to change the text only when necessary, use signals instead of assigning the Node to a variable.
#	...Ex: Call a signal when GVars.spin changes.
#	spinDisplay.text = str(GVars.getScientific(GVars.spin))


func spin_update_loop():
	
	
	
	spinPerCDisplay.text = str(GVars.getScientific(GVars.spinPerClick))
	
	await get_tree().create_timer(0.1).timeout
	spin_update_loop()


func save_loop():
	GVars.save_prog()
	await get_tree().create_timer(20).timeout
	save_loop()


func _changetopreasc():
	if(GVars.numberOfSigils > 2):
		get_tree().change_scene_to_file("res://Scenes/PreAscSpace.tscn")
