extends Resource
class_name BackpackData

@export var cheese : bool
@export var ribbon : bool
#shrugged = hell naw, terrible book

func _init():
	resetData()
	
func resetData() -> void:
	cheese = false
	ribbon = false