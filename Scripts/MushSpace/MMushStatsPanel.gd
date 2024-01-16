extends Sprite2D


## Components
@export var statsDisp : Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_stats()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _update_stats() -> void:
	statsDisp.text = "Buffs\nSpin Buff: " + str(GVars.getScientific(GVars.mushroomData.spinBuff)) + "\nIdentity Buff: " + str(GVars.getScientific(GVars.mushroomData.ascBuff))
