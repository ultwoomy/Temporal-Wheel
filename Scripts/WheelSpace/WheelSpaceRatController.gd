extends Control
@export var rat : TextureButton
@export var letter : Control
@export var lettertext : Label
@export var exit : Button
@export var cheese : TextureButton
var frame := 0.0
var active = true
var cheesepressed = false
var flipout = false
var baseYpos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	letter.hide()
	cheese.hide()
	cheese.disabled = true
	baseYpos = rat.position.y
	#If the value of ratmail is less than the current reset value (which goes 2,4,6,etc), deploy the rat
	#The second value is whenever i want to put the next letter
	if(GVars.ratmail < GVars.ifsecondboot) and GVars.ifsecondboot == 2:
		active = true
	else:
		active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if rat is deployed, move onto the screen
	if(frame < 134) and not flipout and active:
		rat.position = Vector2(-100 + frame * 3, rat.position.y)
		frame += 1
	#if rat is deployed and has been clicked, do a flip
	if flipout and frame < 90 and active:
		rat.position = Vector2(rat.position.x, baseYpos - pow(frame-1,2))
		rat.rotation_degrees = -frame * 4
		frame += 1
	#if flip is complete, disappear
	elif flipout:
		rat.hide()
		active = false
		
	#if the cheese has been pressed, distort
	if cheesepressed and frame < 900:
		cheese.scale = Vector2(0.7 + frame/100,0.7)
		frame += 1
	#if the cheese is sufficiently distorted, disappear and terminate the process
	elif cheesepressed:
		cheese.hide()
		set_process(false)


func _on_rat_pressed():
	#immediately flip the rat
	rat.disabled = true
	flipout = true
	frame = 0
	GVars.ratmail = GVars.ifsecondboot
	#check the ratmail value, display letter text depending on output
	if GVars.ratmail == 2:
		#if first reset, show the cheese
		lettertext.text = "I hope this letter finds you in good health.\n
						I just recently moved in next door, and am keen to greet my old neighbors. \n
						Enclosed within this letter is a full cheese.\n
						I hope it is... cheesy.\n
						Sincerest sincerities,\n
						Rat"
		cheese.show()
	else:
		lettertext.text = "Woawoagh\nuwagh\nwowow\n\n- The Developer"
	letter.show()


func _on_exit_pressed():
	letter.hide()
	#cheese can only be clicked if letter is down
	if GVars.ratmail == 2:
		cheese.disabled = false


func _on_cheese_pressed():
	if not cheesepressed:
		cheesepressed = true
		frame = 0
