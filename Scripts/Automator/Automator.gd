extends Node
class_name Automator

var automator_data: AutomatorData
var enabled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Constructor. Requires an AutomatorData for creation.
# Probably shouldn't override.
func _init(_automator_data: AutomatorData) -> void:
	automator_data = _automator_data


# Inheriters should override this function.
func _automate() -> void:
	pass
