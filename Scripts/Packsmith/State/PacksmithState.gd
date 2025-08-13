extends RefCounted
class_name PacksmithState


#@ Public Variables
var packsmith : Packsmith


#@ Virtual Methods
func _init(_packsmith : Packsmith) -> void:
	packsmith = _packsmith


func _enter() -> void:
	pass


func _update() -> void:
	pass


func _exit() -> void:
	pass
