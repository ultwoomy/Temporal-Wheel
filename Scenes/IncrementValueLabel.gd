extends Label
class_name IncrementValueLabel


#@ Constants
const LIFETIME : float = 0.75


#@ Public Variables
var timeElapsed : float = 0.0


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _init(value : float) -> void:
	if value >= 0:
		self.text = "+" + str(value)
	else:
		self.text = "-" + str(value)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeElapsed < LIFETIME:
		self.modulate.a = (LIFETIME - timeElapsed) / LIFETIME
		var newScaleValue : float = (LIFETIME - timeElapsed) / LIFETIME
		self.scale = Vector2(newScaleValue, newScaleValue)
		timeElapsed += delta
	else:
		self.queue_free()
