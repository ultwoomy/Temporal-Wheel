extends Control
class_name VoidSpaceRitualShop


#@ Export Variables
@export var text : Label


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")
var enabledSprite = preload("res://Sprites/VoidSpace/candles/candle1enabled.png")
var disabledSprite = preload("res://Sprites/VoidSpace/candles/candle1disabled.png")
var effectsDesc = ["The spin speed of your wheel is\ncurrently multiplied by "
					, "Lose rotations per spin."
					, "Gain a small amount of\nmushroom exp each spin."
					, "Solidify your identity.\nYour wheel currently gives you\n" + str(GVars.getScientific(GVars.ritualData.ascBuff))
					, "Gain a small amount of rust\nper spin"
					, "Gain an increase to rotation\nspeed every rotation, currently\nbeing " + str(GVars.getScientific(GVars.ritualData.rotBuff)) + ". Perpetual!"
					, "Powers the kbity creation\nmachine! It's broken??????"
					, "Consume " + str(GVars.getScientific(GVars.kbityData.kbityThreshSpin)) + " momentum and " + str(GVars.getScientific(GVars.kbityData.kbityThreshRot)) + "\nrotations to create kbity!\n" + str(GVars.getScientific(GVars.kbityData.kbityProgSpin)) + "momentum\n" + str(GVars.getScientific(GVars.kbityData.kbityProgRot)) + "rotations."
					, "Consume " + str(GVars.getScientific(GVars.kbityData.kbityThreshRot)) + "rotations\nYou can do this over several runs\n" + str(GVars.getScientific(GVars.kbityData.kbityProgRot)) + "rotations."
					, "Consume " + str(GVars.getScientific(GVars.kbityData.kbityThreshSpin)) + "momentum\nYou can do this over several runs\n" + str(GVars.getScientific(GVars.kbityData.kbityProgSpin)) + "momentum."]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	setCandleSprites()
	setIdleText()
	GVars.kbityData.kbityProgSpin += GVars.kbityData.kbityAddSpin
	GVars.kbityData.kbityAddSpin = 0
	GVars.kbityData.kbityProgRot += GVars.kbityData.kbityAddRot
	GVars.kbityData.kbityAddRot = 0
	if(GVars.kbityData.kbityProgSpin > GVars.kbityData.kbityThreshSpin):
		GVars.kbityData.kbitySpinCheck = true
	if(GVars.kbityData.kbityProgRot > GVars.kbityData.kbityThreshRot):
		GVars.kbityData.kbityRotCheck = true
	if GVars.kbityData.kbitySpinCheck and GVars.kbityData.kbityRotCheck:
		GVars.kbityData.kbityThreshSpin *= 10000
		GVars.kbityData.kbityProgRot *= 6
		GVars.kbityData.kbityLevel += 1
		emit_signal("kbity_up")
	text.position = Vector2(500,400)
	text.size = Vector2(400,200)


#@ Public Methods
func setIdleText():
	var numOfCandles = 0.0
	for n in GVars.ritualData.candlesLit.size():
		if(GVars.ritualData.candlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 0) and (GVars.sigilData.curSigilBuff == 4):
		numOfCandles -= 1
	if(numOfCandles > 5):
		numOfCandles = 5
	effectsDesc[0] = "The spin speed of your wheel is\ncurrently multiplied by " + str(1 - (numOfCandles * 0.2))
	text.text = effectsDesc[0]


func setCandleSprites():
	for n in GVars.ritualData.candlesLit.size():
		var path = "Ritual/Candle" + str(n + 1)
		if(GVars.ritualData.candlesLit[n]):
			get_node(path).texture_normal = enabledSprite
			get_node(path).texture_focused = enabledSprite
		else: 
			get_node(path).texture_normal = disabledSprite
			get_node(path).texture_focused = disabledSprite


func setDescText(n):
	text.text = effectsDesc[n]


func getPath(cand):
	var path = "Ritual/Candle" + str(cand)
	if(get_node(path).texture_normal == enabledSprite):
		get_node(path).texture_normal = disabledSprite
		get_node(path).texture_focused = disabledSprite
		GVars.ritualData.candlesLit[cand - 1] = false
	else:
		get_node(path).texture_normal = enabledSprite
		get_node(path).texture_focused = enabledSprite
		GVars.ritualData.candlesLit[cand - 1] = true
	setIdleText()


#@ Private Methods
func _on_candle_1_pressed():
	getPath(1)

func _on_candle_2_pressed():
	getPath(2)
	
func _on_candle_3_pressed():
	getPath(3)

func _on_candle_4_pressed():
	getPath(4)

func _on_candle_5_pressed():
	getPath(5)

func _on_candle_6_pressed():
	getPath(6)

func _on_candle_1_mouse_entered():
	setDescText(1)

func _on_candle_2_mouse_entered():
	setDescText(2)

func _on_candle_3_mouse_entered():
	setDescText(3)

func _on_candle_4_mouse_entered():
	setDescText(4)

func _on_candle_5_mouse_entered():
	setDescText(5)

func _on_candle_6_mouse_entered():
	if not GVars.hellChallengeLayer2 == 1:
		setDescText(6)
	else:
		setDescText(7)
