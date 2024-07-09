extends Control


#@ Onready Variables
@onready var saveButton : Button = $SaveButton
@onready var backButton : BaseButton = $BackButton
@onready var quitButton : Button = $QuitButton
@onready var creditsButton : BaseButton = $CreditsButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Private Methods
func _saveButtonPressed() -> void:
	GVars.save_prog()


func _onBackButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)


func _onQuitButtonPressed() -> void:
	GVars.save_prog()
	get_tree().quit()


func _onCreditsButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.CREDITS)
