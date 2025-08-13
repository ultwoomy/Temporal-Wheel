extends Resource  # Required to be a resource if exporting in Sigil.gd. DON'T create resources of this (L.B: could be doing something wrong here)
class_name SigilStrategy
## Sigils have a strategy to tell the game what to do when it is augmented.
## This allows a connection from the sigil to whatever it is the augmented sigil is trying to alter.


#@ Virtual Methods
## Called when sigil is augmented.
func _execute() -> void:
	pass


## Called when sigil is no longer augmented.
func _exit() -> void:
	pass
