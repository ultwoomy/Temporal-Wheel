extends GameButtonAnimation
class_name GameButtonPopAnimation
#  This animation causes the GameButton to "pop"
# by having it grow and shrink back to its original size.


#@ Constants
const NEW_SCALE_VALUE : float = 1.05
const DEFAULT_SCALE_VALUE : float = 1.0
const NEW_SCALE : Vector2 = Vector2(NEW_SCALE_VALUE, NEW_SCALE_VALUE)
const DEFAULT_SCALE : Vector2 = Vector2(DEFAULT_SCALE_VALUE, DEFAULT_SCALE_VALUE)

const ANIMATION_DURATION : float = 0.1


#@ Private Variables
var _elapsedTime : float = 0.0


#@ Inherited Methods
func start() -> void:
	_affectedControlNode.scale = Vector2(NEW_SCALE_VALUE, NEW_SCALE_VALUE)  # Probably unneeded since update() resizes scale anyways.


func update(delta : float) -> void:
	if _elapsedTime < ANIMATION_DURATION:
		# Perform the animation.
		var _lerpValue : float = lerp(NEW_SCALE_VALUE, DEFAULT_SCALE_VALUE, _elapsedTime / ANIMATION_DURATION)  # Decrease scale to get to DEFAULT_SCALE_VALUE
		var _newScale : Vector2 = Vector2(_lerpValue, _lerpValue)
		_affectedControlNode.scale = _newScale
		_elapsedTime += delta
	else:
		# Reset because the animation is complete.
		_elapsedTime = 0.0
		animationCompleted.emit()


func exit() -> void:
	_affectedControlNode.scale = DEFAULT_SCALE
