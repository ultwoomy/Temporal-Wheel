extends Control
class_name UpgradeMenu


#@ Onready Variables
@onready var upgradeButton1 : Button = $Up1Button
@onready var upgradeButton2 : Button = $Up2Button
@onready var upgradeButton3 : Button = $Up3Button
@onready var upgradeButton4 : Button = $Up4Button

@onready var upgradeText1 : Label = $Up1Button/Up1Label
@onready var upgradeText2 : Label = $Up2Button/Up2Label
@onready var upgradeText3 : Label = $Up3Button/Up3Label
@onready var upgradeText4 : Label = $Up4Button/Up4Label

@onready var rustDisplay : Label = $RustDisplay


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rustDisplay.text = str(GVars.getScientific(GVars.rustData.rust))
	
	if(GVars.curEmotionBuff < 0) or (GVars.curEmotionBuff > 4):
		upgradeButton4.hide()
	elif(GVars.curEmotionBuff == 1):
		#fear
		upgradeButton4.text = "Increase Wheel Spin Rate Per\nRotation"
	elif(GVars.curEmotionBuff == 2):
		#cold
		upgradeButton4.text = "Increase Hunger By Percentage\nOf Momentum Needed For\nNext Size"
	elif(GVars.curEmotionBuff == 3):
		#warmth
		upgradeButton4.text = "Increase Mushroom\nExperience Gain"
	elif(GVars.curEmotionBuff == 4):
		#wrath
		upgradeButton4.text = "Increase Effect Of Rust\nUpgrades"
	
	upgradeText1.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseSpinCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseSpin))
	upgradeText2.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseHungerCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseHunger))
	upgradeText3.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseRustCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseRust))
	upgradeText4.text = "Cost: " + str(GVars.getScientific(GVars.rustData.fourthCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.fourth))
	
	upgradeButton1.pressed.connect(self._up01)
	upgradeButton2.pressed.connect(self._up02)
	upgradeButton3.pressed.connect(self._up03)
	upgradeButton4.pressed.connect(self._up04)
	
	updateDisplays()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func updateDisplays():
	if(GVars.curEmotionBuff == 4):
		upgradeText1.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseSpinCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseSpin * GVars.rustData.fourth))
		upgradeText2.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseHungerCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseHunger * GVars.rustData.fourth))
		upgradeText3.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseRustCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseRust * GVars.rustData.fourth))
		upgradeText4.text = "Cost: " + str(GVars.getScientific(GVars.rustData.fourthCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.fourth))
	else:
		upgradeText1.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseSpinCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseSpin))
		upgradeText2.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseHungerCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseHunger))
		upgradeText3.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseRustCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseRust))
		upgradeText4.text = "Cost: " + str(GVars.getScientific(GVars.rustData.fourthCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.fourth))
	rustDisplay.text = str(GVars.getScientific(GVars.rustData.rust))


#@ Private Methods
func _up01():
	if(GVars.rustData.rust >= GVars.rustData.increaseSpinCost):
		GVars.rustData.rust -= GVars.rustData.increaseSpinCost
		GVars.rustData.increaseSpinCost *= GVars.rustData.increaseSpinScaling
		GVars.rustData.increaseSpin += 1
		updateDisplays()


func _up02():
	if(GVars.rustData.rust >= GVars.rustData.increaseHungerCost):
		GVars.rustData.rust -= GVars.rustData.increaseHungerCost
		GVars.rustData.increaseHungerCost *= GVars.rustData.increaseHungerScaling
		GVars.rustData.increaseHunger += 1
		updateDisplays()


func _up03():
	if(GVars.rustData.rust >= GVars.rustData.increaseRustCost):
		GVars.rustData.rust -= GVars.rustData.increaseRustCost
		GVars.rustData.increaseRustCost *= GVars.rustData.increaseRustScaling
		GVars.rustData.increaseRust += 1
		GVars.rustData.perThresh += 1
		updateDisplays()


func _up04():
	if(GVars.rustData.rust >= GVars.rustData.fourthCost):
		GVars.rustData.rust -= GVars.rustData.fourthCost
		GVars.rustData.fourthCost *= GVars.rustData.fourthScaling
		if(GVars.curEmotionBuff == 1):
		#fear
			GVars.rustData.fourth += 0.03
		elif(GVars.curEmotionBuff == 2):
		#cold
			GVars.rustData.fourth += 0.02
		elif(GVars.curEmotionBuff == 3):
		#warmth
			GVars.rustData.fourth *= 1.5
		elif(GVars.curEmotionBuff == 4):
		#wrath
			GVars.rustData.fourth *= 1.2
		updateDisplays()
