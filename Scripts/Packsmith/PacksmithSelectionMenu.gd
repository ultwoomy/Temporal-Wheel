extends Control


## Components
@onready var sigilButton01: Button = $Sigil1/Sigil01Button  # Packsmith Sigil
@onready var sigilButton02: Button = $Sigil2/Sigil02Button  # Candle Sigil
@onready var sigilButton03: Button = $Sigil3/Sigil03Button  # Ascension Sigil
@onready var sigilButton04: Button = $Sigil4/Sigil04Button  # Emptiness Sigil
@onready var sigilButton05: Button = $Sigil5/Sigil05Button  # Ritual Sigil
@onready var sigilButton06: Button = $Sigil6/Sigil06Button  # Hell Sigil


## Signals
signal sigil_button_pressed(sigil: SigilData.Sigils)


## Global Variables
@onready var buttons: Array[Button] = [
	sigilButton01,
	sigilButton02,
	sigilButton03,
	sigilButton04,
	sigilButton05,
	sigilButton06,
]


## Functions
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in buttons:
		if not button.pressed.is_connected(on_sigil_button_pressed):
			button.pressed.connect(on_sigil_button_pressed.bind(button))


func on_sigil_button_pressed(pressedButton: Button) -> void:
	# L.B: pressedButton is the button that was pressed. This function is able to get it from the signal call due to the Callable bind() method.
	#	- Based on the button that was pressed, emit the sigil_button_pressed with the correct parameter.
	match pressedButton:
		sigilButton01:
			sigil_button_pressed.emit(SigilData.Sigils.PACKSMITH)
		sigilButton02:
			sigil_button_pressed.emit(SigilData.Sigils.CANDLE)
		sigilButton03:
			sigil_button_pressed.emit(SigilData.Sigils.ASCENSION)
		sigilButton04:
			sigil_button_pressed.emit(SigilData.Sigils.EMPTINESS)
		sigilButton05:
			sigil_button_pressed.emit(SigilData.Sigils.RITUAL)
		sigilButton06:
			sigil_button_pressed.emit(SigilData.Sigils.HELL)
