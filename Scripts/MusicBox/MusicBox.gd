extends Control
@onready var text : Label = $Label
@onready var nextButton : Button = $DialogueButton
@onready var backButton : TextureButton = $BackButton
@onready var currentSong : Panel = $SongDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	if GVars.ifFirstDrum:
		text.text = "It's looking at you funny"
		nextButton.text = "Look at it funny"
		currentSong.hide()
	else:
		text.text = "The drum aimlessly spins"
		nextButton.hide()
		currentSong.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_dialogue_button_pressed():
	text.text = "The drum floats on indifferently."
	nextButton.hide()
	currentSong.show()
