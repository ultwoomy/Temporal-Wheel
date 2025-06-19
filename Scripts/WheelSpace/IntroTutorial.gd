extends Node
class_name IntroTutorial


#@ Public Method
func start(wheelSpace : WheelSpaceMain) -> void:
	# If starting, hide the buttons from Player.
	
	
	# 
	GVars.spinData.momentumValueChanged.connect(_startGrowTutorialOnMetRequirement.bind(wheelSpace).unbind(1))
	
	# Next, wait for density value to change
	GVars.spinData.sizeValueChanged.connect(_startDensityTutorialOnMetRequirement.bind(wheelSpace))


#@ Private Methods
func _startGrowTutorialOnMetRequirement(wheelSpace : WheelSpaceMain) -> void:
	# If the momentum value has changed, then the Player has probably clicked the spin button a few times.
	const REQUIRED_AMOUNT_OF_MOMENTUM : float = 50 
	var fulfillsRequirement : bool = GVars.spinData.momentum >= REQUIRED_AMOUNT_OF_MOMENTUM
	
	# Reveal the grow button.
	if fulfillsRequirement:
		wheelSpace.growButton.show()
		GVars.spinData.momentumValueChanged.disconnect(self._startGrowTutorialOnMetRequirement)
	
	## TODO: EventManager.tutorial_grow_found.emit()
	##  Figure out what that connects to, and change it so that its functionality is in here instead.
	##  - This is how the bunny pops out of hiding and teaches the player.


func _startDensityTutorialOnMetRequirement(wheelSpace : WheelSpaceMain) -> void:
	# If the density value has changed, then the Player has probably clicked on the density button.
	var fulfillsRequirement : bool = GVars.spinData.size > 2
	var failsafe : bool = GVars.spinData.density > 1  # L.B: This is probably unneeded and should be removed unless you have a plan for it, Yuwomy.
	
	# Reveal the density button.
	if fulfillsRequirement or failsafe:
		wheelSpace.densityButton.show()
		GVars.spinData.densityValueChanged.disconnect(self._startDensityTutorialOnMetRequirement)
		
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)
		sf.start(load("res://Sound/SFX/nono.wav"))
	
	wheelSpace.densityButton.densityGauge.size.x = GVars.spinData.curSucDens/GVars.spinData.densTresh * 2 * 100  # TODO: L.B - This seems odd that it has its own function. Maybe there's a fix?
