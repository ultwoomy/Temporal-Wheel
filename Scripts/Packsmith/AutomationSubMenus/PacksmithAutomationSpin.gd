extends Control
class_name AutomationSubMenuSpin

@onready var pricetag : Label = $Panel/Price
@onready var spinBotBuyButton : Button = $Panel/SpinbotPanel/Button

func _ready():
	refreshPage()
	
func _on_buy_pressed():
	get_parent().buyAutomator("Spinbot")
	refreshPage()

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
	if Automation.contains("Spinbot"):
		spinBotBuyButton.hide()

func exit():
	queue_free()
