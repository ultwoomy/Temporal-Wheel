extends Control
class_name AutomationSubMenuVoid

@onready var pricetag : Label = $Panel/Price
@onready var voidBotBuyButton : Button = $Panel/VoidbotPanel/Button

func _ready():
	refreshPage()
	
func _on_buy_pressed():
	get_parent().buyAutomator("Voidbot")
	refreshPage()

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
	if Automation.contains("Voidbot"):
		voidBotBuyButton.hide()

func exit():
	queue_free()
