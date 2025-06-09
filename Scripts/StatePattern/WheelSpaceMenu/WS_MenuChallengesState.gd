extends WS_MenuState
class_name WS_MenuChallengesState


#@ Constants
const CHALLENGES_PANEL_SCENE : Resource = preload("res://Scenes/WheelSpace/ChallengesPanel.tscn")


#@ Variables
var challengesPanel : Control = CHALLENGES_PANEL_SCENE.instantiate()


#@ Virtual Methods
func _enter() -> void:
	wheelSpace.add_child(challengesPanel)


func _exit() -> void:
	challengesPanel.queue_free()
