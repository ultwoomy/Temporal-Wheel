extends Control
@export var openCButton : Button
@export var left : TextureButton
@export var right : TextureButton
@export var exit : TextureButton
@export var enterContract : Button
@export var soulupgrade : Button
var panel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	left.hide()
	right.hide()
	exit.hide()
	enterContract.hide()
	soulupgrade.hide()

func _on_e_contract_page_pressed():
	position = Vector2(0,0)
	show()
	left.show()
	right.show()
	exit.show()
	enterContract.show()
	openCButton.hide()

func toTheLeft():
	panel -= 1
	if(panel < 0):
		panel = 3
	switchPanel()
	
func toTheRight():
	panel += 1
	if(panel > 3):
		panel = 0
	switchPanel()
	
func switchPanel():
	moveOut(false)
	if(panel == 0):
		get_parent().get_node("ContractPage").show()
		get_parent().get_node("ContractPage").position = Vector2(0,0)
		if(checkDone()):
			get_parent().get_node("ContractPage").get_node("Control").get_node("ContractDesc").text = "Chance of double shroom\nOr double dollar\nCost: " + str(GVars.soulsData.doubleShroomChanceCost) + "\nCurrently: " + str(GVars.soulsData.doubleShroomChance) + "%"
			enterContract.hide()
			soulupgrade.show()
	elif(panel == 1):
		get_parent().get_node("ContractPage2").show()
		get_parent().get_node("ContractPage2").position = Vector2(0,0)
		if(checkDone()):
			get_parent().get_node("ContractPage").get_node("Control").get_node("ContractDesc").text = "Chance of double rotations\nCost: " + str(GVars.soulsData.doubleRotChanceCost) + "\nCurrently: " + str(GVars.soulsData.doubleRotChance) + "%"
			enterContract.hide()
			soulupgrade.show()
	elif(panel == 2):
		get_parent().get_node("ContractPage3").show()
		get_parent().get_node("ContractPage3").position = Vector2(0,0)
		if(checkDone()):
			get_parent().get_node("ContractPage").get_node("Control").get_node("ContractDesc").text = "Increase base momentum\nBased on momentum\nCost: " + str(GVars.soulsData.spinBaseBuffCost) + "\nCurrently: log(" + str(GVars.soulsData.spinBaseBuff) + ")"
			enterContract.hide()
			soulupgrade.show()
	elif(panel == 3):
		get_parent().get_node("ContractPage4").show()
		get_parent().get_node("ContractPage4").position = Vector2(0,0)
		if(checkDone()):
			get_parent().get_node("ContractPage").get_node("Control").get_node("ContractDesc").text = "Chance of void rust\nOr double rust\nCost: " + str(GVars.soulsData.voidRustChanceCost) + "\nCurrently: " + str(GVars.soulsData.voidRustChance) + "%"
			enterContract.hide()
			soulupgrade.show()
		
func beginContract():
	GVars.hellChallengeLayer2 = panel
	get_tree().change_scene_to_file("res://Scenes/AscensionSpace.tscn")
		
func _on_exit_pressed():
	panel = 0
	moveOut(true)
	
func moveOut(ifexit):
	position = Vector2(1000,0)
	hide()
	if ifexit:
		left.hide()
		right.hide()
		exit.hide()
		enterContract.hide()
		soulupgrade.hide()
		get_parent().get_node("ContractPage2").hide()
		get_parent().get_node("ContractPage3").hide()
		get_parent().get_node("ContractPage4").hide()
		openCButton.show()
	else:
		left.show()
		right.show()
		exit.show()
		enterContract.show()
		soulupgrade.hide()
		get_parent().get_node("ContractPage2").hide()
		get_parent().get_node("ContractPage3").hide()
		get_parent().get_node("ContractPage4").hide()
		openCButton.hide()

func checkDone():
	if(panel == 0):
		if GVars.soulsData.doubleShroomChanceEnabled:
			return true
		else:
			return false
	elif(panel == 1):
		if GVars.soulsData.doubleRotChanceEnabled:
			return true
		else:
			return false
	elif(panel == 2):
		if GVars.soulsData.spinBaseBuffEnabled:
			return true
		else:
			return false
	elif(panel == 3):
		if GVars.soulsData.voidRustChanceEnabled:
			return true
		else:
			return false
	
func _process(_delta):
	get_node("Control").get_node("ContractSigil").rotation += 0.002
	get_parent().get_node("ContractPage2").get_node("Control").get_node("ContractSigil").rotation += 0.002
	get_parent().get_node("ContractPage3").get_node("Control").get_node("ContractSigil").rotation += 0.002
	get_parent().get_node("ContractPage4").get_node("Control").get_node("ContractSigil").rotation += 0.002
