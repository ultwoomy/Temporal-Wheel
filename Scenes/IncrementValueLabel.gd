extends Label
class_name IncrementValueLabel


#@ Constants
const LIFETIME : float = 0.75
const FONT_SIZE : int = 35


#@ Public Variables
var timeElapsed : float = 0.0


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _init(value : float) -> void:
	# Change text upon spawning.
	if value >= 0:
		self.text = "+" + str(GVars.getScientific(value))
	else:
		self.text = "-" + str(GVars.getScientific(value))
	
	


func _ready() -> void:
	# Change font size.
	self.add_theme_font_size_override("font_size", FONT_SIZE)
	
	# Set origin point and anchor point to center, as well as text alignment.
	self.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	self.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	self.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	self.pivot_offset = self.size / 2.0  # For rescaling.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeElapsed < LIFETIME:
		self.modulate.a = (LIFETIME - timeElapsed) / LIFETIME
		var newScaleValue : float = (LIFETIME - timeElapsed) / LIFETIME
		self.scale = Vector2(newScaleValue, newScaleValue)
		self.position.y -= timeElapsed * 3
		timeElapsed += delta
	else:
		self.queue_free()
