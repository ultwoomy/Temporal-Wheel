extends TutorialBunnyState
class_name TutorialBunnyGrowState


#@ Constants
const DIALOGUE_JSON_FILE_PATH : String = "res://JSON/Dialogue/TutorialBunny/TutorialBunnyIntroduction.json"
const DIALOGUE_INFO_KEY : String = "grow_info"
const DIALOGUE_GROW_TOGGLED_ON_KEY : String = "grow_toggled_on"
const DIALOGUE_GROW_TOGGLED_OFF_KEY : String = "grow_toggled_off"


#@ Public Variables
var dialogueHandler : DialogueHandler = DialogueHandler.new()
var dialogueLineIndex : int = 0


#@ Virtual Methods
func _enter() -> void:
	dialogueHandler.dialogueFilePath = DIALOGUE_JSON_FILE_PATH


## WIP
## WIP
## WIP
func _onGrowButtonPressed(toggled) -> void:
	if toggled:
		dialogueHandler.getDialogueData(DIALOGUE_INFO_KEY)
	else:
		pass
