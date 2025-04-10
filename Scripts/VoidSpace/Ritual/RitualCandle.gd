extends TextureButton
class_name RitualCandle


#@ Export Variables
@export var candleIndex : int
@export_custom(PROPERTY_HINT_EXPRESSION, "") var description : String :
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
