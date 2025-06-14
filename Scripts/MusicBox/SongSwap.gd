extends Control
@onready var left : TextureButton = $Left
@onready var right : TextureButton = $Right
@onready var back : Sprite2D = $Back
@onready var sigil : AnimatedSprite2D = $SongSigil
@onready var text : Label = $Title
@onready var desc : Label = $Desc
@onready var swap : Button = $Swap
var displayedTrack = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	checkCurrentTrack()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_left_pressed():
	displayedTrack -= 1
	if displayedTrack < 0:
		displayedTrack = 2
	checkCurrentTrack()
	
func _on_right_pressed():
	displayedTrack += 1
	if displayedTrack > 2:
		displayedTrack = 0
	checkCurrentTrack()

func checkCurrentTrack():
	if displayedTrack == GVars.currentTrack:
		swap.hide()
	else:
		swap.show()
	if displayedTrack == 0:
		text.text = "MKD20"
		desc.text = "Music box fragment of Mikage's Diary by Harumaki Gohan"
	elif displayedTrack == 1:
		text.text = "SL40"
		desc.text = "Music box fragment of Strobe Light by PowaPowaP"
	elif displayedTrack == 2:
		text.text = "SYT80"
		desc.text = "Music box fragment of See You Tomorrow by 想太 (soh_ta__)"


func _on_swap_pressed() -> void:
	GVars.currentTrack = displayedTrack
	checkCurrentTrack()
	EventManager.refresh_song.emit()
