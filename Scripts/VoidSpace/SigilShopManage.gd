extends Node
@export var text : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	text.position = Vector2(450,300)
	text.text = "Here for a sigil?\nIt'll cost ya:"

