extends Button


#@ Export Variables
@export var mslider : VSlider
@export var sslider : VSlider


#@ Public Variables
var show = false


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._wheelScene)
	mslider.hide()
	sslider.hide()
	mslider.value = GVars.musicvol
	sslider.value = GVars.sfxvol


func _wheelScene():
	if not show:
		mslider.show()
		sslider.show()
		text = "Volume\nMusic|SFX"
		show = true
	else:
		mslider.hide()
		sslider.hide()
		text = "Volume"
		show = false


func _on_slide_music(_value_changed):
	GVars.musicvol = mslider.value
	var musicbox = get_tree().root.get_node("SoundManage").get_child(0)
	if(GVars.musicvol == -24):
		musicbox.stream_paused = true
	else:
		if(musicbox.stream_paused):
			musicbox.stream_paused = false
		musicbox.volume_db = GVars.musicvol


func _on_slide_sfx(_value_changed):
	GVars.sfxvol = sslider.value
