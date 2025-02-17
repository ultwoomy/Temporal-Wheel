extends Node
class_name SoundManager


var curtrack = 0
var pos = 0
var tracks = []
var sfx = []
var musicbox = AudioStreamPlayer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	tracks.append(preload("res://Sound/Music/MKD20.wav"))
	tracks.append(preload("res://Sound/Music/SL40.wav"))
	add_child(musicbox)
	musicbox.stream = tracks[0]
	musicbox.finished.connect(reset)
	musicbox.volume_db = GVars.musicvol
	check_track()
	musicbox.play()
	musicbox.stream_paused = true
	get_tree().get_root().get_node("EventManager").wheel_spun.connect(check_track)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(GVars.spinData.spin == 0) and !musicbox.stream_paused:
		pos = musicbox.get_playback_position()
		musicbox.stream_paused = true
	elif musicbox.stream_paused and GVars.spinData.spin > 0 and GVars.musicvol != -24:
		musicbox.stream_paused = false

func reset():
	musicbox.play(0.0)
	
func playMKD(n):
	var place = musicbox.get_playback_position()
	musicbox.stream = tracks[GVars.currentTrack]
	musicbox.pitch_scale = n
	musicbox.play(place)

func check_track():
	if(GVars.musicvol != -24):
		if(GVars.spinData.spin > 10000):
			playMKD(1.0)
		elif(GVars.spinData.spin > 100):
			playMKD(0.8)
		else:
			playMKD(0.5)
