extends PacksmithState
class_name PacksmithDefaultState


#@ Constants
const STATE_POSITION : Vector2 = Vector2(700, 393)
const STATE_ROTATION_DEGREES : float = 0.0
const TWEEN_DURATION : float = 0.5
const EYEBROW_POSITION : Vector2 = Vector2(122, -177)
const EYEBROW_ANIMATION : String = "angry"


#@ Virtual Methods
func _enter() -> void:
	if not packsmith.position == STATE_POSITION:
		_moveToStatePosition()


func _update() -> void:
	pass


func _exit() -> void:
	pass


#@ Private Methods
func _moveToStatePosition() -> void:
	var tween : Tween = packsmith.create_tween()
	tween.parallel().tween_property(packsmith, "position", STATE_POSITION, TWEEN_DURATION).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(packsmith, "rotation_degrees", STATE_ROTATION_DEGREES, TWEEN_DURATION)
