extends AudioStreamPlayer

func init(sound):
	stream = sound
	volume_db = GVars.sfxvol
	if!(volume_db == -24):
		play()
	else:
		queue_free()

func _on_finished():
	queue_free()
