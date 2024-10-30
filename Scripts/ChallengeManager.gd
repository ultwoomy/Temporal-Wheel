extends Node
class_name ChallengeManager


#@ Export Variables
@export var buttonContainers : Array[Control]  # (.) Maybe these valid button containers should have their own designated class.


#@ Public Variables


#@ Private Variables


#@ Virtual Methods
func _ready() -> void:
	EventManager.refresh_challenges.connect(self.refresh)
	for challenge in Challenger.currentChallenges:  # This is used to get the class, since the method has(ChallengeStrategy) checks if Node is a Script- which is false.
		if challenge is FabulousCStrat:
			_setupFabulousChallenge(challenge)


#@ Public Methods
func refresh():
	for challenge in Challenger.currentChallenges:  # This is used to get the class, since the method has(ChallengeStrategy) checks if Node is a Script- which is false.
		if challenge is FabulousCStrat:
			disconnectThorns(challenge)
			EventManager.emit_signal("thorn_disconnect_complete")
		
func disconnectThorns(challenge):
	for buttonContainer in buttonContainers:
		var fabulousChallengeComponent : FabulousCComp = buttonContainer.fabulousChallengeComponent
		if fabulousChallengeComponent:
			fabulousChallengeComponent.thornyButtonDamageResolved.disconnect(challenge.applyDamage)
			buttonContainer.button.pressed.disconnect(fabulousChallengeComponent.onThornyButtonPressed)

#@ Private Methods
func _setupFabulousChallenge(challenge : FabulousCStrat) -> void:
	for buttonContainer in buttonContainers:
		var fabulousChallengeComponent : FabulousCComp = buttonContainer.fabulousChallengeComponent
		if fabulousChallengeComponent:
			fabulousChallengeComponent.thornyButtonDamageResolved.connect(challenge.applyDamage)
			buttonContainer.button.pressed.connect(fabulousChallengeComponent.onThornyButtonPressed)
