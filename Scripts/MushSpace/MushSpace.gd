extends GameScene
class_name MushSpace


#@ Signals


#@ Enumerators
enum MushroomCrops {
	LAMP,  # 0
	ROT,  # 1
	WINE,  # 2... etc
	TWIN,
	FEAR,
}


#@ Constants
const MUSHROOM_CROPS_RESOURCES : Dictionary = {
	MushroomCrops.LAMP: preload("res://Resources/Mushroom Crop/Lamp.tres"),
	MushroomCrops.ROT: preload("res://Resources/Mushroom Crop/Rot.tres"),
	MushroomCrops.WINE: preload("res://Resources/Mushroom Crop/Wine.tres"),
	MushroomCrops.TWIN: preload("res://Resources/Mushroom Crop/Twin.tres"),
	MushroomCrops.FEAR: preload("res://Resources/Mushroom Crop/Fear.tres"),
}


#@ Onready Variables
@onready var background : Sprite2D = $Background
@onready var mushRoom : AnimatedSprite2D = $MushRoom
@onready var mushbot : Sprite2D = $Mushbot

@onready var farmPlots : MushFarmPlots = $FarmPlots
@onready var infoPanel : MushInfoPanel = $InfoPanel
@onready var farmButtons : MushFarmButtons = $FarmButtons
@onready var levelDisplay : MushLevelDisplay = $LevelDisplay
@onready var statsPanel : MushStatsPanel = $StatsPanel

@onready var planter : MushFarmPlanter = $Planter
@onready var harvester : MushFarmHarvester = $Harvester
@onready var remover : MushFarmRemover = $Remover

@onready var backButton : Button = $BackButton


#@ Public Variables
var mushroomSelected : MushroomCrops = 0  # 0 is the first item in the enumerator.


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals
	if not WheelSpinner.wheelRotationCompleted.is_connected(updateFromPendingRotations):
		WheelSpinner.wheelRotationCompleted.connect(updateFromPendingRotations)
	_connectFarmButtonSignals()
	_connectInfoPanelSignals()
	
	# Firstly, make sure that when the Player enters the scene, time has gone by for the mushrooms to grow.
	updateFromPendingRotations()
	
	# Show the necessary visuals.
	_setMushbotVisibility(Automation.contains("Mushbot"))  # If the Player has a Mushbot automator, then show the Mushbot.
	_displayMushRoomSprite()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#@ Public Methods
# Reduce the time for mushrooms to grow depending on how many rotations has passed since last visiting MushSpace.
func updateFromPendingRotations() -> void:
	# Make sure pendingRotations is not negative.
	if GVars.mushroomData.pendingRots < 0:
		GVars.mushroomData.pendingRots = 0
	
	# Reduce time for harvest for every plot that has a mushroom growing in it.
	for mushroomPlotIndex in GVars.mushroomData.currentFarmPlots.size():
		GVars.mushroomData.timeLeft[mushroomPlotIndex] -= GVars.mushroomData.pendingRots
		if GVars.mushroomData.timeLeft[mushroomPlotIndex] <= 0:
			GVars.mushroomData.timeLeft[mushroomPlotIndex] = 0
	GVars.mushroomData.pendingRots = 0


func selectNextCrop() -> void:
	mushroomSelected += 1
	if mushroomSelected >= MushroomCrops.size():
		mushroomSelected = 0


func selectPreviousCrop() -> void:
	mushroomSelected -= 1
	if mushroomSelected < 0:
		mushroomSelected = MushroomCrops.size() - 1


#@ Private Methods
func _connectFarmButtonSignals() -> void:
	if farmButtons:
		farmButtons.plantButton.pressed.connect(planter.plant.bind(_getMushroomCropResource()))
		farmButtons.harvestButton.pressed.connect(harvester.harvest)
		farmButtons.removeButton.pressed.connect(remover.remove)
	else:
		printerr("ERROR: Unable to connect farm button signals! Are there no buttons for controling the mushroom farm?")


func _connectInfoPanelSignals() -> void:
	if infoPanel:
		infoPanel.leftArrowButton.pressed.connect(selectPreviousCrop)
		infoPanel.rightArrowButton.pressed.connect(selectNextCrop)
	else:
		printerr("ERROR: Unable to connect info panel signals! Does an info panel exist in the scene?")


func _setMushbotVisibility(condition : bool) -> void:
	mushbot.visible = condition


# Change the look of the mushroom room (where the farm plots are) depending on the level.
func _displayMushRoomSprite() -> void:
	const LEVEL_REQUIREMENT : int = 10
	
	if GVars.mushroomData.level >= LEVEL_REQUIREMENT:
		mushRoom.frame = 2


func _getMushroomCropResource() -> MushroomCrop:
	var newMushroomCrop : MushroomCrop = MUSHROOM_CROPS_RESOURCES.get(mushroomSelected)
	
	# Error checking
	if not newMushroomCrop:
		printerr("ERROR: Unable to get correct mushroom crop resource for the mushroom crop selected!")
	
	return newMushroomCrop
