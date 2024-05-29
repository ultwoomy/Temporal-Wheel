extends Control
class_name SelectionMenu


#@ Signals
signal sigil_button_pressed(sigil: SigilData.Sigils)


#@ Components
@onready var packsmithSigil : SelectionMenuSigil = $PacksmithSigil
@onready var candleSigil 	: SelectionMenuSigil = $CandleSigil
@onready var ascensionSigil : SelectionMenuSigil = $AscensionSigil
@onready var emptinessSigil : SelectionMenuSigil = $EmptinessSigil
@onready var ritualSigil 	: SelectionMenuSigil = $RitualSigil
@onready var hellSigil 		: SelectionMenuSigil = $HellSigil


#@ Global Variables
@onready var sigils: Array[SelectionMenuSigil] = [
	packsmithSigil,
	candleSigil,
	ascensionSigil,
	emptinessSigil,
	ritualSigil,
	hellSigil,
]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_up_sigils()


#@ Public Methods
func set_up_sigils() -> void:
	for sigil in sigils:
		if sigil:
			# Check to see if the button is not already connected.
			if not sigil.button.pressed.is_connected(emit_signal_on_sigil_button_pressed):
				# Passes the assigned sigil into the function using the sigil.sigil variable.
				# The sigil.sigil is an export variable that you assign to sigil instances.
				sigil.button.pressed.connect(emit_signal_on_sigil_button_pressed.bind(sigil.sigil))


# Display the correct sigils based on 
func display_sigils() -> void:
	# Copied and pasted code w/ modifications to get the same declared variable.
	if GVars.sigilData.numberOfSigils[1]:
		candleSigil.show()
	else:
		candleSigil.hide()
	if GVars.sigilData.numberOfSigils[2]:
		ascensionSigil.show()
	else:
		ascensionSigil.hide()
	if GVars.sigilData.numberOfSigils[3]:
		emptinessSigil.show()
	else:
		emptinessSigil.hide()
	if GVars.sigilData.numberOfSigils[4]:
		ritualSigil.show()
	else:
		ritualSigil.hide()
	if GVars.sigilData.numberOfSigils[5]:
		hellSigil.show()
	else:
		hellSigil.hide()


# Emits the sigiL_button_pressed signal with the correct parameters depending on which sigil button was pressed.
func emit_signal_on_sigil_button_pressed(sigil: SigilData.Sigils) -> void:
	sigil_button_pressed.emit(sigil)
