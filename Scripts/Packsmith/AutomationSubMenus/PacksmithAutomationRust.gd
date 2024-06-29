extends Control
class_name AutomationSubMenuRust

@onready var pricetag : Label = $Panel/Price
@onready var rustBotBuyButton : Button = $Panel/RustbotPanel/Button
@onready var toggle : Button = $Panel/Button

func _ready():
	refreshPage()
	if GVars.automatorVarsData.rustAutoBuyEnabled:
		toggle.text = "Autobuy: Enabled"
	else:
		toggle.text = "Autobuy: Disabled"
	
func _on_buy_pressed():
	get_parent().buyAutomator("Rustbot")
	refreshPage()

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
	if Automation.contains("Rustbot"):
		rustBotBuyButton.hide()
		toggle.show()
	else:
		toggle.hide()

func exit():
	queue_free()


func _on_toggle_pressed():
	if GVars.automatorVarsData.rustAutoBuyEnabled:
		GVars.automatorVarsData.rustAutoBuyEnabled = false
		toggle.text = "Autobuy: Disabled"
	else:
		GVars.automatorVarsData.rustAutoBuyEnabled = true
		toggle.text = "Autobuy: Enabled"
