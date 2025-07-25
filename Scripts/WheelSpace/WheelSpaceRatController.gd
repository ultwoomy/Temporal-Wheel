extends Control


#@ Export Variables
@export var rat : TextureButton
@export var letter : Control
@export var lettertext : Label
@export var exit : Button
@export var cheese : TextureButton
@export var bow: TextureButton

#@ Public Variables
var frame := 0.0
var active = true
var cheesepressed = false
var flipout = false
var baseYpos = 0
var activeTimes = [1,3,7]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	letter.hide()
	cheese.hide()
	bow.hide()
	rat.hide()
	cheese.disabled = true
	bow.disabled = true
	rat.disabled = true
	baseYpos = rat.position.y
	#if the player exits before accepting the cheese, activate it anyways
	if GVars.ratmail >= 2 and not GVars.backpackData.cheese:
		GVars.backpackData.cheese = true
	if GVars.ratmail >= 4 and not GVars.backpackData.ribbon:
		GVars.backpackData.ribbon = true
	if GVars.ratmail >= 8 and not GVars.backpackData.drum:
		GVars.backpackData.drum = true
	#If the value of ratmail is less than the current reset value (which goes 2,4,6,etc), deploy the rat
	#The second value is whenever i want to put the next letter
	if(GVars.ratmail < GVars.ifSecondBoot) and containsTime(GVars.ifSecondBoot):
		active = true
		rat.disabled = false
		rat.show()
	else:
		active = false


func containsTime(x):
	for i in activeTimes:
		if i == x:
			return true
	return false


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


#@ Private Methods
func _on_rat_pressed():
	#immediately flip the rat
	rat.disabled = true
	flipout = true
	frame = 0
	GVars.ratmail = GVars.ifSecondBoot
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
		cheese.disabled = false
	elif GVars.ratmail == 4:
		#if second reset, give a bow
		lettertext.text = "I greet you once again.\n
						   Me and my family thank you for passing a full day.\n
						   I'm sure the entire universe appreciates your work.\n
						   Enclosed is a bow, you may do with it as you like.\n
						   Sincerest sincerities,\n
						   Rat"
		bow.show()
		bow.disabled = false
	elif GVars.ratmail == 8:
		#if second reset, give a bow
		lettertext.text = "I hear solemn notes in this barren land.\n
						   I've sent my people to find the source.\n
						   And we've recovered this strange obelisk.\n
						   Not sure what it is, perhaps you can make use of it.\n
						   Check your backpack, my child has stashed it in there.\n
						   Sincerest sincerities,\n
						   Rat"
		GVars.backpackData.drum = true
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
		GVars.backpackData.cheese = true


func _on_bow_pressed():
	GVars.backpackData.ribbon = true
	bow.hide()
