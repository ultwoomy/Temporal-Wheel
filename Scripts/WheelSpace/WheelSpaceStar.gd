extends Sprite2D
class_name WheelSpaceStar


#@ Signals
signal blinkFinished(star : WheelSpaceStar)


#@ Public Variables
var loopingBlink : bool = true


#@ Virtual Methods
func _init() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self._blink(loopingBlink)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#@ Public Methods
func randomizeLook() -> void:
	self._randomizeFlip()
	self._randomizeRotation()
	self._randomizeSize()


#@ Private Methods
func _blink(loop : bool) -> void:
	const TWEEN_DURATION : float = 0.4
	var waitDuration : float = randf_range(3.0, 15.0)
	
	await get_tree().create_timer(waitDuration).timeout
	var tween : Tween = self.create_tween()
	tween.tween_property(self, "self_modulate", Color(Color.WHITE, 0.0), TWEEN_DURATION)
	
	await tween.finished
	blinkFinished.emit(self)
	if loop:
		self.randomizeLook()
		self.self_modulate = Color.WHITE
		_blink(loopingBlink)


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
