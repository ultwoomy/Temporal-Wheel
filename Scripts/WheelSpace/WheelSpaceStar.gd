extends Sprite2D
class_name WheelSpaceStar


#@ Signals
signal blinkFinished(star : WheelSpaceStar)


#@ Constants


#@ Public Variables
var blinking : bool = true
var pulsing : bool = true


#@ Private Variables
var spinTween : Tween


#@ Onready Variables
@onready var clickableArea : Area2D = $Area2D


#@ Virtual Methods
func _init() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.self_modulate = Color(Color.WHITE, 0.0)  # Start off by being invisible.
	self._blink(blinking)
	self._pulse(pulsing)
	
	# Connect signals.
	var checkCorrectInputCallable : Callable = func checkCorrectInput(viewport : Node, event : InputEvent, shape_idx : int) -> void:
		if event.is_action_pressed("mouseLeftClick"):
			if not spinTween:
				_spin()
	clickableArea.input_event.connect(checkCorrectInputCallable)


#@ Public Methods
func randomizeLook() -> void:
	self._randomizeFlip()
	self._randomizeRotation()
	self._randomizeSize()


#@ Private Methods
func _blink(loop : bool) -> void:
	const TWEEN_DURATION : float = 0.4
	var waitDuration : float = randf_range(3.0, 30.0)
	
	# Fade in.
	var tween : Tween = self.create_tween()
	tween.tween_property(self, "self_modulate", Color.WHITE, TWEEN_DURATION)
	await tween.finished
	tween.kill()
	
	# Fade out.
	await get_tree().create_timer(waitDuration).timeout
	tween = self.create_tween()
	tween.tween_property(self, "self_modulate", Color(Color.WHITE, 0.0), TWEEN_DURATION)
	await tween.finished
	
	blinkFinished.emit(self)
	if loop:
		self.randomizeLook()
		self._blink(blinking)


func _pulse(loop : bool) -> void:
	const TWEEN_DURATION : float = 1.5
	var defaultScale : Vector2 = self.scale
	var pulseMaxScale : Vector2 = self.scale + Vector2(0.10, 0.10)
	
	var tween : Tween = self.create_tween()
	tween.tween_property(self, "scale", pulseMaxScale, TWEEN_DURATION)
	tween.tween_property(self, "scale", defaultScale, TWEEN_DURATION)
	await tween.finished
	
	if loop:
		self.scale = defaultScale
		self._pulse(pulsing)


func _spin() -> void:
	const TWEEN_DURATION : float = 0.1
	var defaultRotation : float = self.rotation_degrees
	var rotationGoal : float = self.rotation_degrees - 360  # Negative to make it look like it is moving clockwise thanks to TWEEN_DURATION.
	
	spinTween = self.create_tween()
	spinTween.tween_property(self, "rotation_degrees", rotationGoal, TWEEN_DURATION)
	await spinTween.finished
	spinTween.kill()
	
	self.rotation_degrees = defaultRotation
	spinTween = null


func _randomizeFlip() -> void:
	var randomHorizontal : bool = randi_range(0, 1)
	var randomVertical : bool = randi_range(0, 1)
	
	self.flip_h = randomHorizontal
	self.flip_v = randomVertical


func _randomizeRotation() -> void:
	const MIN_ANGLE : float = 0.0
	const MAX_ANGLE : float = 360.0
	var randomAngle : float = randf_range(MIN_ANGLE, MAX_ANGLE)
	
	self.rotation_degrees = randomAngle


func _randomizeSize() -> void:
	const MIN_SCALE : float = 0.75
	const MAX_SCALE : float = 1.20
	var randomScale : float = randf_range(MIN_SCALE, MAX_SCALE)
	
	self.scale = Vector2(randomScale, randomScale)
