extends Control
class_name AutomationMenu

@onready var pricetag : Label = $Panel/Price

func _ready():
	pricetag.text = "Cost in       :" + str(GVars.automatorVarsData.globalAutomatorCostSpin) + "\nCost in       :" + str(GVars.automatorVarsData.globalAutomatorCostRust)
