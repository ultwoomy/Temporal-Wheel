extends Panel


#@ Signals
signal confirmed
signal canceled


#@ Export Variables


#@ Public Variables


#@ Onready Variables
@onready var descriptionLabel : Label = $DescriptionLabel


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	if not GVars.ifhell and GVars.sigilData.curSigilBuff == 5:
		get_child(0).text = "You are about to enter a hell challenge corresponding to you current emotion buff. Are you prepared?"


#@ Public Methods


#@ Private Methods
func _onYesButtonPressed() -> void:
	confirmed.emit()
	hide()


func _onNoButtonPressed() -> void:
	canceled.emit()
	hide()
