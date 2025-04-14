extends Control
class_name VoidSpaceRitualShop


#@ Export Variables


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")
var enabledSprite = preload("res://Sprites/VoidSpace/candles/candle1enabled.png")
var disabledSprite = preload("res://Sprites/VoidSpace/candles/candle1disabled.png")


#@ Onready Variables
@onready var sigilLabel : Label = $SigilLabel
@onready var ritual : Ritual = $Ritual


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Listen and connect signals
	for candle in ritual.candles:
		candle.pressed.connect(_onRitualCandlePressed.bind(candle))
		candle.mouse_entered.connect(_onRitualCandleHovered.bind(candle))
		candle.mouse_exited.connect(displaySpinSpeedText)
	
	hide()
	displaySpinSpeedText()
	
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


#@ Public Methods
func displaySpinSpeedText():
	sigilLabel.text = "The spin speed of your wheel is\ncurrently multiplied by " + str(1 - (GVars.ritualData.totalLitCandles * 0.2))


#@ Private Methods
func _onRitualCandlePressed(candle : RitualCandle) -> void:
	var toggledOn : bool = candle.texture_normal == Ritual.CANDLE_SPRITE_ENABLED
	if toggledOn:
		candle.texture_normal = Ritual.CANDLE_SPRITE_DISABLED
	else:
		candle.texture_normal = Ritual.CANDLE_SPRITE_ENABLED
	GVars.ritualData.candlesLit[candle.candleIndex] = not toggledOn
	displaySpinSpeedText()


func _onRitualCandleHovered(candle : RitualCandle) -> void:
	sigilLabel.text = candle.description
