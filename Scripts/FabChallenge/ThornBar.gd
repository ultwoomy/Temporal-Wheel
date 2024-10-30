extends Control
@export var text : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	print("pee")
	get_window().add_child(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
