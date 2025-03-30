extends GameScene
class_name MushSpace


#@ Signals


#@ Enumerators


#@ Constants


#@ Onready Variables
@onready var background : Sprite2D = $Background
@onready var mushRoom : AnimatedSprite2D = $MushRoom
@onready var mushbot : Sprite2D = $Mushbot

@onready var farmPlots : MushFarmPlots = $FarmPlots
@onready var infoPanel : MushInfoPanel = $InfoPanel
@onready var farmButtons : MushFarmButtons = $FarmButtons
@onready var levelDisplay : MushLevelDisplay = $LevelDisplay
@onready var statsPanel : MushStatsPanel = $StatsPanel

@onready var selector : MushFarmSelector = $Selector
@onready var planter : MushFarmPlanter = $Planter
@onready var harvester : MushFarmHarvester = $Harvester
@onready var remover : MushFarmRemover = $Remover

@onready var backButton : Button = $BackButton


#@ Public Variables


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals
	if not WheelSpinner.wheelRotationCompleted.is_connected(updateFromPendingRotations):
		WheelSpinner.wheelRotationCompleted.connect(updateFromPendingRotations)
	_connectFarmButtonSignals()
	_connectInfoPanelSignals()
	_connectSelectorSignals()
	
	# Firstly, make sure that when the Player enters the scene, time has gone by for the mushrooms to grow.
	updateFromPendingRotations()
	
	# Show the necessary visuals.
	_setMushbotVisibility(Automation.contains("Mushbot"))  # If the Player has a Mushbot automator, then show the Mushbot.
	_displayMushRoomSprite()
	infoPanel.displayMushroomCropInfo(selector.getMushroomCropResource())



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


#@ Private Methods
func _connectFarmButtonSignals() -> void:
	farmButtons.plantButton.pressed.connect(
		func _plantMushroomFromResource() -> void:  # Get the selected mushroom crop data from selector, then plant it.
			return planter.plant(selector.getMushroomCropResource())
	)
	farmButtons.harvestButton.pressed.connect(harvester.harvest)
	farmButtons.removeButton.pressed.connect(remover.remove)


func _connectInfoPanelSignals() -> void:
	infoPanel.leftArrowButton.pressed.connect(selector.selectPreviousCrop)
	infoPanel.rightArrowButton.pressed.connect(selector.selectNextCrop)


func _connectSelectorSignals() -> void:
	selector.mushroomSelectionChanged.connect(
		func _displayMushroomCropInfo() -> void:
			return infoPanel.displayMushroomCropInfo(selector.getMushroomCropResource())
	)


func _setMushbotVisibility(condition : bool) -> void:
	mushbot.visible = condition


# Change the look of the mushroom room (where the farm plots are) depending on the level.
func _displayMushRoomSprite() -> void:
	const LEVEL_REQUIREMENT : int = 10
	
	if GVars.mushroomData.level >= LEVEL_REQUIREMENT:
		mushRoom.frame = 2
