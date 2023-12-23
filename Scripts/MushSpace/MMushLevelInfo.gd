extends Control


## Components
@export var xpBarProgress : Sprite2D  # L.B: I don't know whether this should be XpBar or XpBarProgress.
@export var leveldisp : Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_xp_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _update_xp_bar() -> void:
	xpBarProgress.scale.x = GVars.mushroomData.xp / GVars.mushroomData.xpThresh * 1.5
	leveldisp.text = "Level: " + str(GVars.getScientific(GVars.mushroomData.level))
