extends Node
@export var spinDisplay: Label
@export var spinPerCDisplay: Label
@export var sizeDisplay: Label
@export var densDisplay: Label
@export var rotsDisplay: Label
@export var button : Button
@export var mushroom : TextureButton
@export var spinbody : CharacterBody2D
@export var changepreasc : Button
var fmat = preload("res://Scripts/FormatNo.gd")
var dismush = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile002.png")
func _ready():
	save_loop()
	spinDisplay.text = ""
	spin_update_loop()
	if(GVars.numberOfSigils > 1):
		mushroom.disabled = false
	else:
		mushroom.disabled = true
		mushroom.texture_hover = dismush
		mushroom.texture_pressed = dismush
		mushroom.texture_focused = dismush
	button.size = Vector2(200,100)
	button.text = "Spin"
	button.expand_icon = true
	spinDisplay.text = str(GVars.spin)
	button.pressed.connect(self._button_pressed)
	mushroom.pressed.connect(self._mush_scene)
	spinbody.oneClick.connect(_button_pressed)
	changepreasc.pressed.connect(self._changetopreasc)
func _button_pressed():
	GVars.spin += GVars.spinPerClick * GVars.size * GVars.density * GVars.Rincreasespin * GVars.Sspinbuff
	spinDisplay.text = str(GVars.getScientific(GVars.spin))
func spin_update_loop():
	spinDisplay.text = str(GVars.getScientific(GVars.spin))
	sizeDisplay.text = str(GVars.getScientific(GVars.size))
	densDisplay.text = str(GVars.getScientific(GVars.density))
	spinPerCDisplay.text = str(GVars.getScientific(GVars.spinPerClick))
	rotsDisplay.text = str("Rotations: ",GVars.getScientific(GVars.rotations))
	await get_tree().create_timer(0.1).timeout
	spin_update_loop()
func save_loop():
	GVars.save_prog()
	await get_tree().create_timer(20).timeout
	save_loop()
func _mush_scene():
	get_tree().change_scene_to_file("res://Scenes/MushSpace.tscn")
func _changetopreasc():
	if(GVars.numberOfSigils > 2):
		get_tree().change_scene_to_file("res://Scenes/PreAscSpace.tscn")
