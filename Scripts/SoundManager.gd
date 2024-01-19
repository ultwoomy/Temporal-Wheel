extends Node
class_name SoundManager
var curtrack = 0
var pos = 0
var tracks = []
var sfx = []
var musicbox = AudioStreamPlayer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	tracks.append(preload("res://Sound/Music/MKD/MKD10.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD20.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD30.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD40.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD50.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD60.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD70.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD80.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD90.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD100.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD110.wav"))
	tracks.append(preload("res://Sound/Music/MKD/MKD120.wav"))
	add_child(musicbox)
	musicbox.stream = tracks[0]
	musicbox.finished.connect(reset)
	musicbox.volume_db = GVars.musicvol
	musicbox.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(GVars.spinData.spin == 0) and !musicbox.stream_paused:
		pos = musicbox.get_playback_position()
		musicbox.stream_paused = true
	if musicbox.stream_paused and GVars.spinData.spin > 0:
		musicbox.stream_paused = false
	if(GVars.spinData.spinSpeed != curtrack):
		musicbox.pitch_scale = float(GVars.spinData.density) / 10 + 0.7
		if((GVars.spinSpeed >= curtrack + 10) or (GVars.spinSpeed <= curtrack - 10)) and GVars.spinSpeed < 111:
			curtrack = GVars.spinSpeed
			if(curtrack < 10):
				musicbox.stream = tracks[0]
				musicbox.play()
			elif(curtrack < 20):
				pos = musicbox.get_playback_position()/2
				musicbox.stream = tracks[1]
				musicbox.play(pos)
			elif(curtrack < 30):
				pos = 2*musicbox.get_playback_position()/3
				musicbox.stream = tracks[2]
				musicbox.play(pos)
			elif(curtrack < 40):
				pos = 3*musicbox.get_playback_position()/4
				musicbox.stream = tracks[3]
				musicbox.play(pos)
			elif(curtrack < 50):
				pos = 4*musicbox.get_playback_position()/5
				musicbox.stream = tracks[4]
				musicbox.play(pos)
			elif(curtrack < 60):
				pos = 5*musicbox.get_playback_position()/6
				musicbox.stream = tracks[5]
				musicbox.play(pos)
			elif(curtrack < 70):
				pos = 6*musicbox.get_playback_position()/7
				musicbox.stream = tracks[6]
				musicbox.play(pos)
			elif(curtrack < 80):
				pos = 7*musicbox.get_playback_position()/8
				musicbox.stream = tracks[7]
				musicbox.play(pos)
			elif(curtrack < 90):
				pos = 8*musicbox.get_playback_position()/9
				musicbox.stream = tracks[8]
				musicbox.play(pos)
			elif(curtrack < 100):
				pos = 9*musicbox.get_playback_position()/10
				musicbox.stream = tracks[9]
				musicbox.play(pos)
			elif(curtrack < 110):
				pos = 10*musicbox.get_playback_position()/11
				musicbox.stream = tracks[10]
				musicbox.play(pos)
			else:
				pos = 11*musicbox.get_playback_position()/12
				musicbox.stream = tracks[11]
				musicbox.play(pos)

func reset():
	musicbox.play(0.0)
