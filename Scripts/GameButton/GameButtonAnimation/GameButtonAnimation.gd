extends RefCounted
class_name GameButtonAnimation


#@ Signals
signal animationCompleted


#@ Private Variables
var _affectedControlNode : Control


#@ Virtual Methods
func _init(affectedControlNode : Control) -> void:
	_affectedControlNode = affectedControlNode


#@ Public Methods
func start() -> void:
	pass


func update(delta : float) -> void:
	pass


func exit() -> void:
	pass
