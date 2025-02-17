extends Node


#@ Onready Variables
@onready var audioStreamPlayer : AudioStreamPlayer = $AudioStreamPlayer


func start(sound : AudioStream):
	audioStreamPlayer.stream = sound
	audioStreamPlayer.volume_db = GVars.sfxvol
	if not audioStreamPlayer.volume_db == -24:
		audioStreamPlayer.finished.connect(_onAudioStreamPlayerFinished)
		audioStreamPlayer.play()
	else:
		audioStreamPlayer.queue_free()


func _onAudioStreamPlayerFinished():
	queue_free()
