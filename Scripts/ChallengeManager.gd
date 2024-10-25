extends Node
class_name ChallengeManager


#@ Export Variables
@export var buttonContainers : Array[Control]  # (.) Maybe these valid button containers should have their own designated class.


#@ Public Variables


#@ Private Variables


#@ Virtual Methods
func _ready() -> void:
	for challenge in Challenger.currentChallenges:  # This is used to get the class, since the method has(ChallengeStrategy) checks if Node is a Script- which is false.
		if challenge is FabulousCStrat:
			_setupFabulousChallenge(challenge)


#@ Public Methods


#@ Private Methods
func _setupFabulousChallenge(challenge : FabulousCStrat) -> void:
	for buttonContainer in buttonContainers:
		var fabulousChallengeComponent : FabulousCComp = buttonContainer.fabulousChallengeComponent
		if fabulousChallengeComponent:
			fabulousChallengeComponent.thornyButtonDamageResolved.connect(challenge.applyDamage)
			buttonContainer.button.pressed.connect(fabulousChallengeComponent.onThornyButtonPressed)
