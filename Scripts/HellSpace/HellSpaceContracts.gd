extends Control
@export var openCButton : Button
@export var left : TextureButton
@export var right : TextureButton
@export var exit : TextureButton
@export var enterContract : Button
@export var soulupgrade : Button
@export var soulcount : Sprite2D
var panel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	left.hide()
	right.hide()
	exit.hide()
	enterContract.hide()
	soulupgrade.hide()
	soulcount.hide()

func _on_e_contract_page_pressed():
	position = Vector2(0,0)
	show()
	left.show()
	right.show()
	exit.show()
	soulcount.show()
	enterContract.show()
	openCButton.hide()
	soulcount.show()
	print("f")
	switchPanel()

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
		panelGeneric("Chance of double shroom\nOr double dollar\nCost: " + str(GVars.soulsData.doubleShroomChanceCost) + "\nCurrently: " + str(GVars.soulsData.doubleShroomChance) + "%", "ContractPage")
	elif(panel == 1):
		panelGeneric("Chance of double rotations\nCost: " + str(GVars.soulsData.doubleRotChanceCost) + "\nCurrently: " + str(GVars.soulsData.doubleRotChance) + "%", "ContractPage2")
	elif(panel == 2):
		panelGeneric("Increase base momentum\nBased on momentum\nCost: " + str(GVars.soulsData.spinBaseBuffCost) + "\nCurrently: log(" + str(GVars.soulsData.spinBaseBuff) + ")", "ContractPage3")
	elif(panel == 3):
		panelGeneric("Chance of void rust\nOr double rust\nCost: " + str(GVars.soulsData.voidRustChanceCost) + "\nCurrently: " + str(GVars.soulsData.voidRustChance) + "%", "ContractPage4")
			
func panelGeneric(descText, page):
	get_parent().get_node(page).show()
	get_parent().get_node(page).position = Vector2(0,0)
	if(checkDone()):
		get_parent().get_node(page).get_node("Control").get_node("ContractDesc").text = descText
		enterContract.hide()
		soulupgrade.show()
		
func beginContract():
	GVars.hellChallengeLayer2 = panel
	GVars.hellChallengeInit = true
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
		soulcount.hide()
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
		soulcount.show()
		get_parent().get_node("ContractPage2").hide()
		get_parent().get_node("ContractPage3").hide()
		get_parent().get_node("ContractPage4").hide()
		openCButton.hide()

func checkDone():
	if(panel == 0):
		return GVars.soulsData.doubleShroomChanceEnabled
	elif(panel == 1):
		return GVars.soulsData.doubleRotChanceEnabled
	elif(panel == 2):
		return GVars.soulsData.spinBaseBuffEnabled
	elif(panel == 3):
		return GVars.soulsData.voidRustChanceEnabled
	
func _process(_delta):
	get_node("Control").get_node("ContractSigil").rotation += 0.002
	get_parent().get_node("ContractPage2").get_node("Control").get_node("ContractSigil").rotation += 0.002
	get_parent().get_node("ContractPage3").get_node("Control").get_node("ContractSigil").rotation += 0.002
	get_parent().get_node("ContractPage4").get_node("Control").get_node("ContractSigil").rotation += 0.002
