extends TextureButton
var fmat = preload("res://Scripts/FormatNo.gd")
var enabledSprite = preload("res://Sprites/VoidSpace/candles/candle1enabled.png")
var disabledSprite = preload("res://Sprites/VoidSpace/candles/candle1disabled.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	setCandleSprites()
	if Automation.contains("Voidbot"):
		show()
	else:
		hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	setCandleSprites()
	if get_child(0).is_visible():
		get_child(0).hide()
	else:
		get_child(0).show()
		
func getPath(cand):
	var path = "RitualShop/Ritual/Candle" + str(cand)
	if(get_node(path).texture_normal == enabledSprite):
		get_node(path).texture_normal = disabledSprite
		get_node(path).texture_focused = disabledSprite
		GVars.ritualData.candlesLit[cand - 1] = false
	else:
		get_node(path).texture_normal = enabledSprite
		get_node(path).texture_focused = enabledSprite
		GVars.ritualData.candlesLit[cand - 1] = true

func setCandleSprites():
	for n in GVars.ritualData.candlesLit.size() - 1:
		var path = "RitualShop/Ritual/Candle" + str(n + 1)
		if(GVars.ritualData.candlesLit[n]):
			get_node(path).texture_normal = enabledSprite
			get_node(path).texture_focused = enabledSprite
		else: 
			get_node(path).texture_normal = disabledSprite
			get_node(path).texture_focused = disabledSprite


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
