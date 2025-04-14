extends TextureButton
class_name RitualCandle


#@ Constants
const SPRITE_ENABLED : CompressedTexture2D = preload("res://Sprites/VoidSpace/candles/candle1enabled.png")
const SPRITE_DISABLED : CompressedTexture2D = preload("res://Sprites/VoidSpace/candles/candle1disabled.png")


#@ Export Variables
@export var candleIndex : int
@export_custom(PROPERTY_HINT_EXPRESSION, "") var description : String :  # This allows for variables to be used in the Inspector using the Expression class.
	get():
		# Parse the multiline into actual code.
		var error : Error = _expression.parse(description, _inputs.keys())
		if error:
			print("Expression parse error: ", _expression.get_error_text())
			return ""
		
		# Execute the code.
		var result = _expression.execute(_inputs.values(), self)
		if _expression.has_execute_failed():
			print("Expression failed: ", _expression.get_error_text())
			return ""
		return result


#@ Private Variables
var _expression : Expression = Expression.new()
var _inputs : Dictionary = {
	"GVars": GVars,
}


#@ Virtual Methods
func _ready() -> void:
	# If the candle is already enabled, show that the candle is enabled. Otherwise, show that it is disabled.
	self.texture_normal = SPRITE_ENABLED if GVars.ritualData.candlesLit[candleIndex] else SPRITE_DISABLED
