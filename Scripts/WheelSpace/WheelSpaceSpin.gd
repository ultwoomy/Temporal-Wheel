extends Node
@export var spinDisplay: Label
@export var spinPerCDisplay: Label
@export var sizeDisplay: Label
@export var densDisplay: Label
@export var rotsDisplay: Label
@export var button : Button
var fmat = preload("res://Scripts/FormatNo.gd")
var dispSpin
func _ready():
	spin_update_loop()
	button.size = Vector2(200,100)
	button.text = "Spin"
	button.expand_icon = true
	spinDisplay.text = str(GVars.spin)
	button.pressed.connect(self._button_pressed)
func get_spin_text(val):
	if(val > 1000):
		dispSpin = fmat.scientific(val,2)
	else :
		dispSpin = val
	return dispSpin
func _button_pressed():
	GVars.spin += GVars.spinPerClick * GVars.size * GVars.density
	spinDisplay.text = str(get_spin_text(GVars.spin))
	GVars.save_prog()
func spin_update_loop():
	spinDisplay.text = str(get_spin_text(GVars.spin))
	sizeDisplay.text = str(get_spin_text(GVars.size))
	densDisplay.text = str(get_spin_text(GVars.density))
	spinPerCDisplay.text = str(get_spin_text(GVars.spinPerClick))
	rotsDisplay.text = str("Rotations: ",get_spin_text(GVars.rotations))
	await get_tree().create_timer(0.1).timeout
	spin_update_loop()
