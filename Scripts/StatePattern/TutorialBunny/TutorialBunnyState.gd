extends State
class_name TutorialBunnyState


#@ Public Variables
var tutorialBunny : TutorialBunny


#@ Virtual Methods
func _init(_tutorialBunny : TutorialBunny) -> void:
	tutorialBunny = _tutorialBunny


func _onGrowButtonPressed(toggled : bool) -> void:
	pass


func _onDensityButtonPressed() -> void:
	pass
