extends PacksmithMenuState
class_name UpgradeState
# This state is transitioned into when the Inspect button from PacksmithMenu is pressed.
# Causes the selection menu to be shown, and then hidden when state is exited.


#@ Virtual Methods
func _enter() -> void:
	# Show the inspect selection menu.
#	packsmithMenu.upgrade.show()
#	packsmithMenu.upgrade.display_sigils()
	
	# Listen for any signals.
	if not packsmithMenu.inspectButton.pressed.is_connected(_onInspectButtonPressed):
		packsmithMenu.inspectButton.pressed.connect(_onInspectButtonPressed)


func _update(delta: float) -> void:
	pass


func _exit() -> void:
	packsmithMenu.selection.hide()


#@ Private Methods
func _onInspectButtonPressed() -> void:
	packsmithMenu.changeState(PickState.new(packsmithMenu))
