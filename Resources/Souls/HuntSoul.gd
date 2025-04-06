extends Resource
class_name HuntSoul
# How many rotations is needed to catch the soul
@export var length : float
@export var cost : float
@export var sprite : Texture2D
@export var xp : float
@export var soulvalue : float
@export var name : String
@export var minimumLevel : int
@export var description : String


func _init() -> void:
	resetData()
	
func resetData():
	length = 0
	cost = 0
	xp = 0
	soulvalue = 0
	name = ""
	minimumLevel = 0
