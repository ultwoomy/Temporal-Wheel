extends Control
class_name AutomationSubMenuVoid

@onready var pricetag : Label = $Panel/Price
@onready var voidBotBuyButton : Button = $Panel/VoidbotPanel/Button
@onready var voidDesc : Label = $Panel/VoidbotPanel/Label

func _ready():
	refreshPage()
	voidDesc.text = "A disturbingly human like fae, it has flown in from a different dimension full of the desire to do some trolling. It has decided to dedicate its remaining life time to trolling, the first of which, will be to steal some momentum."
	
func _on_buy_pressed():
	get_parent().buyAutomator("Voidbot")
	refreshPage()

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
	if Automation.contains("Voidbot"):
		voidBotBuyButton.hide()

func exit():
	queue_free()


func _on_effects_pressed():
	voidDesc.text = "Effects:\nAllows you to switch candles on and off from Wheelspace, provided you have unlocked Ritual."
