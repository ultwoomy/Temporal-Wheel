extends Control
class_name AutomationSubMenuSpin

@onready var pricetag : Label = $Panel/Price
@onready var spinBotBuyButton : Button = $Panel/SpinbotPanel/Button
@onready var spinDesc : Label = $Panel/SpinbotPanel/Label

func _ready():
	refreshPage()
	spinDesc.text = "An ancient object, older than time itself. It's only purpose is to spin around in cirlces. It is very happy with this. For a price, it will spin your wheel in circles for you."
	
func _on_buy_pressed():
	get_parent().buyAutomator("Spinbot")
	refreshPage()

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
	if Automation.contains("Spinbot"):
		spinBotBuyButton.hide()

func exit():
	queue_free()


func _on_effects_pressed():
	spinDesc.text = "Effects:\nGain 1 clicks worth of momentum on every wheelspin."
