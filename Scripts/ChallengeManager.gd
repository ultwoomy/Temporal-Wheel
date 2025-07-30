extends Node
class_name ChallengeManager


#@ Export Variables
@export var buttonContainers : Array[Control]  # (.) Maybe these valid button containers should have their own designated class.


#@ Public Variables


#@ Private Variables


#@ Onready Variables
## TODO: INSTEAD OF HAVING THIS BE IN THE SCENE, JUST INSTANTIATE IT IF NEEDED.
@onready var thornsBackgroundSprite : Sprite2D = $ThornsBackgroundSprite


#@ Virtual Methods
func _ready() -> void:
	EventManager.refresh_challenges.connect(self.refresh)
	EventManager.disconnect_thorns.connect(self.disconnectThorns)
	
	## TODO: INSTEAD OF HAVING THIS BE IN THE SCENE, JUST INSTANTIATE IT IF NEEDED.
	## THIS WOULD SOLVE THIS ERROR CHECK BY ITSELF.
	if thornsBackgroundSprite:
		thornsBackgroundSprite.hide()
	await get_tree().create_timer(0.1).timeout
	refresh()


#@ Public Methods
func refresh():
	for challenge in Challenger.currentChallenges:  # This is used to get the class, since the method has(ChallengeStrategy) checks if Node is a Script- which is false.
		if challenge is FabulousCStrat:
			print("hh")
			_setupFabulousChallenge(challenge)


func disconnectThorns(challenge):
	thornsBackgroundSprite.hide()
	for buttonContainer in buttonContainers:
		var fabulousChallengeComponent : FabulousCComp = buttonContainer.fabulousChallengeComponent
		if fabulousChallengeComponent:
			fabulousChallengeComponent.thornyButtonDamageResolved.disconnect(challenge.applyDamage)
			buttonContainer.button.pressed.disconnect(fabulousChallengeComponent.onThornyButtonPressed)


#@ Private Methods
func _setupFabulousChallenge(challenge : FabulousCStrat) -> void:
	thornsBackgroundSprite.show()
	thornsBackgroundSprite.modulate = Color(1,1,1, (float(GVars.bleedstacks))/4)
	for buttonContainer in buttonContainers:
		var fabulousChallengeComponent : FabulousCComp = buttonContainer.fabulousChallengeComponent
		if fabulousChallengeComponent:
			if not fabulousChallengeComponent.thornyButtonDamageResolved.is_connected(challenge.applyDamage):
				fabulousChallengeComponent.thornyButtonDamageResolved.connect(challenge.applyDamage)
				buttonContainer.button.pressed.connect(fabulousChallengeComponent.onThornyButtonPressed)
