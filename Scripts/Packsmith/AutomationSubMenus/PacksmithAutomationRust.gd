extends Control
class_name AutomationSubMenuRust

@onready var pricetag : Label = $Panel/Price
@onready var rustBotBuyButton : Button = $Panel/RustbotPanel/Button
@onready var rustDesc : Label = $Panel/RustbotPanel/Label
@onready var toggle : Button = $Panel/Button

func _ready():
	refreshPage()
	if GVars.automatorVarsData.rustAutoBuyEnabled:
		toggle.text = "Autobuy: Enabled"
	else:
		toggle.text = "Autobuy: Disabled"
	rustDesc.text = "A small green square, filled with anger at being so poorly drawn. It hates the packsmith, and has decided to benevolently give you alternatives to speaking with them for a one time price."
	
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


func _on_effects_pressed():
	rustDesc.text = "Effects:\nAutobuys rust upgrades even when not on screen. Allows you to augment sigils from Rustspace, skipping dialouge."
