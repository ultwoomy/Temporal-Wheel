extends Control
class_name AutomationMenu

@onready var pricetag : Label = $Panel/Price
@onready var rustBotBuyButton : Button = $Panel/RustbotPanel/Button
@onready var voidBotBuyButton : Button = $Panel/VoidbotPanel/Button
@onready var mushBotBuyButton : Button = $Panel/MushbotPanel/Button
@onready var spinBotBuyButton : Button = $Panel/SpinbotPanel/Button
@onready var rustScene = preload("res://Scenes/Packsmith/AutomationSubMenus/AutomationRustMenu.tscn")
@onready var voidScene = preload("res://Scenes/Packsmith/AutomationSubMenus/AutomationVoidMenu.tscn")
@onready var mushScene = preload("res://Scenes/Packsmith/AutomationSubMenus/AutomationMushMenu.tscn")
@onready var spinScene = preload("res://Scenes/Packsmith/AutomationSubMenus/AutomationSpinMenu.tscn")
func _ready():
	refreshPage()

func _on_rustbuy_pressed():
	var instance = rustScene.instantiate()
	add_child(instance)


func _on_voidbuy_pressed():
	var instance = voidScene.instantiate()
	add_child(instance)


func _on_mushbuy_pressed():
	var instance = mushScene.instantiate()
	add_child(instance)


func _on_spinbuy_pressed():
	var instance = spinScene.instantiate()
	add_child(instance)

func buyAutomator(type) -> bool:
	refreshPage()
	if GVars.rustData.rust > GVars.automatorVarsData.globalAutomatorCostRust and GVars.spinData.spin > GVars.automatorVarsData.globalAutomatorCostSpin:
		GVars.rustData.rust -= GVars.automatorVarsData.globalAutomatorCostRust
		GVars.spinData.spin -= GVars.automatorVarsData.globalAutomatorCostSpin
		GVars.automatorVarsData.globalAutomatorCostRust *= GVars.automatorVarsData.globalAutomatorScalingRust
		GVars.automatorVarsData.globalAutomatorCostSpin = pow(GVars.automatorVarsData.globalAutomatorCostSpin, GVars.automatorVarsData.globalAutomatorScalingSpin)
		GVars.automatorVarsData.automatorList.append(type)
		Automation.updateActive()
		return true
	return false

func refreshPage():
	pricetag.text = "Cost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostSpin)) + "\nCost in       :" + str(GVars.getScientific(GVars.automatorVarsData.globalAutomatorCostRust))
