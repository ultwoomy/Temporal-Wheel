extends Node
@export var midplayer : MidiPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	midplayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
