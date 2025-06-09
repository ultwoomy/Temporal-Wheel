extends WS_MenuState
class_name WS_MenuBackpackState


#@ Constants
const BACKPACK_PANEL_SCENE : Resource = preload("res://Scenes/WheelSpace/BackpackPanel.tscn")


#@ Variables
var backpackPanel : Control = BACKPACK_PANEL_SCENE.instantiate()


#@ Virtual Methods
func _enter() -> void:
	wheelSpace.add_child(backpackPanel)


func _exit() -> void:
	backpackPanel.queue_free()
