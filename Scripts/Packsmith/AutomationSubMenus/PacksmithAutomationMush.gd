extends Control
class_name AutomationSubMenuMush

@onready var pricetag : Label = $Panel/Price
@onready var mushBotBuyButton : Button = $Panel/MushbotPanel/Button

func _ready():
	refreshPage()
	
func _on_buy_pressed():
	get_parent().buyAutomator("Mushbot")
	refreshPage()

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
	if Automation.contains("Mushbot"):
		mushBotBuyButton.hide()

func exit():
	queue_free()
