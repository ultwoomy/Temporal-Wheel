extends RefCounted
class_name GameButtonAnimation


#@ Signals
signal animationCompleted


#@ Private Variables
var _effectedControlNode : Control


#@ Virtual Methods
func _init(effectedControlNode : Control) -> void:
	_effectedControlNode = effectedControlNode


#@ Public Methods
func start() -> void:
	pass


func update(delta : float) -> void:
	pass


func exit() -> void:
	pass
