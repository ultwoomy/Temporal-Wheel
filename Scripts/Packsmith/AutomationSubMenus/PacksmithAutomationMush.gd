extends Control
class_name AutomationSubMenuMush

@onready var pricetag : Label = $Panel/Price
@onready var mushBotBuyButton : Button = $Panel/MushbotPanel/Button
@onready var mushDesc : Label = $Panel/MushbotPanel/Label

func _ready():
	refreshPage()
	mushDesc.text = "Agent of God, who came down to the mortal plane to spread the good word of mushroom growing. It has grown an interest in your activites, and has agreed to facilitate your growing given a small fee."
	
func _on_buy_pressed():
	get_parent().buyAutomator("Mushbot")
	refreshPage()

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
	if Automation.contains("Mushbot"):
		mushBotBuyButton.hide()

func exit():
	queue_free()


func _on_effects_pressed():
	mushDesc.text = "Effect:\nAutomatically harvests and replants shrooms. They will grow when you are in Mushspace."
