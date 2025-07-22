extends Node
class_name IntroTutorial


#@ Constants
const REQUIRED_AMOUNT_OF_MOMENTUM_TO_UNLOCK_GROW_BTN : float = 50
const REQUIRED_SIZE_TO_UNLOCK_DENSITY_BTN : int = 3
const TUTORIAL_BUNNY_SCENE : PackedScene = preload("res://Scenes/WheelSpace/TutorialBunny.tscn")


#@ Public Variables
var tutorialBunny : TutorialBunny


#@ Public Method
func start(wheelSpace : WheelSpaceMain) -> void:
	# Check to see if tutorial is no longer needed.
	if not GVars.ifFirstBoot:
		return
	
	wheelSpace.growButton.hide()
	wheelSpace.densityButton.hide()
	wheelSpace.travelButton.hide()
	
	# 
	GVars.spinData.momentumValueChanged.connect(_startGrowTutorialOnMetRequirement.bind(wheelSpace).unbind(1))
	_startGrowTutorialOnMetRequirement(wheelSpace)


#@ Private Methods
func _startGrowTutorialOnMetRequirement(wheelSpace : WheelSpaceMain) -> void:
	# If the momentum value has changed, then the Player has probably clicked the spin button a few times.
	var fulfillsRequirement : bool = GVars.spinData.momentum >= REQUIRED_AMOUNT_OF_MOMENTUM_TO_UNLOCK_GROW_BTN
	var failsafe : bool = GVars.spinData.sizeToggle
	
	if fulfillsRequirement or failsafe:
		# Reveal the grow button.
		wheelSpace.growButton.show()
		GVars.spinData.momentumValueChanged.disconnect(self._startGrowTutorialOnMetRequirement)
		
		# Reveal the tutorial bunny.
		tutorialBunny = TUTORIAL_BUNNY_SCENE.instantiate()
		wheelSpace.add_child(tutorialBunny)
		wheelSpace.move_child(tutorialBunny, wheelSpace.growButton.get_index() - 1)
		tutorialBunny.introduceSelf()
		wheelSpace.growButton.toggled.connect(tutorialBunny._onGrowButtonPressed)
		wheelSpace.densityButton.button.pressed.connect(tutorialBunny._resetAndDisplayDialogue)
		
		# Next, wait for size value to change
		GVars.spinData.sizeValueChanged.connect(_startDensityTutorialOnMetRequirement.bind(wheelSpace))
		_startDensityTutorialOnMetRequirement(wheelSpace)


func _startDensityTutorialOnMetRequirement(wheelSpace : WheelSpaceMain) -> void:
	# If the size value has changed, then the Player has probably clicked and toggled on the grow button.
	var fulfillsRequirement : bool = GVars.spinData.size >= REQUIRED_SIZE_TO_UNLOCK_DENSITY_BTN
	var failsafe : bool = GVars.spinData.density > 1
	
	if fulfillsRequirement or failsafe:
		# Reveal the density button.
		wheelSpace.densityButton.show()
		GVars.spinData.sizeValueChanged.disconnect(self._startDensityTutorialOnMetRequirement)
		wheelSpace.growButton.toggled.disconnect(tutorialBunny._onGrowButtonPressed)
		
		wheelSpace.densityButton.densityGauge.size.x = GVars.spinData.curSucDens/GVars.spinData.densTresh * 2 * 100  # TODO: L.B - This seems odd that it has its own function. Maybe there's a fix?
		
		# Next, wait for density value to change
		GVars.spinData.densityValueChanged.connect(_startTravelTutorialOnMetRequirement.bind(wheelSpace))
		_startTravelTutorialOnMetRequirement(wheelSpace)


func _startTravelTutorialOnMetRequirement(wheelSpace : WheelSpaceMain) -> void:
	# If the density value has changed, then the Player has probably pressed the density button.
	var fulfillsRequirement : bool = GVars.spinData.density >= 2
	
	if fulfillsRequirement:
		# Reveal the travel button.
		wheelSpace.travelButton.show()
		wheelSpace.densityButton.button.pressed.disconnect(tutorialBunny._resetAndDisplayDialogue)
