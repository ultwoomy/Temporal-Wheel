extends Panel
@onready var desc : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateText()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateText():
	desc.text = "Sand Dollar Count: " + str(GVars.getScientific(GVars.dollarData.sandDollars)) +  "\n\nUpon reset, you will
	 start out with:\n" + str(GVars.getScientific(GVars.dollarData.insuranceAmtSpin)) + " Momentum
	\n" + str(GVars.getScientific(GVars.dollarData.insuranceAmtRot)) + " Rotations\n" + str(GVars.getScientific(GVars.dollarData.insuranceAmtRust)) + " Rust\n\nInsurance Upgrade 
	Cost: " + str(GVars.getScientific(GVars.dollarData.insuranceCost)) + " sand dollars\nGet sand dollars by completing achievements"

func _on_upgrade_insurance_pressed() -> void:
	if GVars.dollarData.sandDollars >= GVars.dollarData.insuranceCost:
		GVars.dollarData.sandDollars -= GVars.dollarData.insuranceCost
		GVars.dollarData.insuranceCost += GVars.dollarData.insuranceScaling
		GVars.dollarData.insuranceAmtSpin *= GVars.dollarData.insuranceAmtSpinUp
		GVars.dollarData.insuranceAmtRot += GVars.dollarData.insuranceAmtRotUp
		GVars.dollarData.insuranceAmtRust *= GVars.dollarData.insuranceAmtRustUp
	updateText()
