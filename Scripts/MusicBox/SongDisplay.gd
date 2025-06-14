extends Panel
@onready var text : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	checkSong()
	EventManager.refresh_song.connect(self.checkSong)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func checkSong():
	var nextText = "\nCurrently Playing:\n"
	if GVars.currentTrack == 0:
		nextText += "MKD20"
	elif GVars.currentTrack == 1:
		nextText += "SL40"
	elif GVars.currentTrack == 2:
		nextText += "SYT80"
	text.text = nextText
