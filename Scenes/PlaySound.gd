extends Node


#@ Onready Variables
@onready var audioStreamPlayer : AudioStreamPlayer = $AudioStreamPlayer


func start(sound : AudioStream):
	# Error checking.
	if not audioStreamPlayer:
		printerr("ERROR: Unable to access audio stream player to play sound! Is the sound effect node in the scene?")
		return
	
	audioStreamPlayer.stream = sound
	audioStreamPlayer.volume_db = GVars.sfxvol
	if not audioStreamPlayer.volume_db == -24:
		audioStreamPlayer.finished.connect(_onAudioStreamPlayerFinished)
		audioStreamPlayer.play()
	else:
		audioStreamPlayer.queue_free()


func _onAudioStreamPlayerFinished():
	queue_free()
