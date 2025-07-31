extends Control
class_name WheelSpaceBackground


#@ Constants
const STAR_SPRITE : CompressedTexture2D = preload("res://Sprites/WheelSpace/Sky/star.png")
const BASE_AMOUNT_OF_STARS : int = 5


#@ Public Variables
var numberOfStars : int


#@ Onready Variables
@onready var colorRect : ColorRect = $ColorRect
@onready var starsParent : Control = $Stars


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numberOfStars = BASE_AMOUNT_OF_STARS + GVars.numberOfTimesAscended
	createStars()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass


#@ Public Methods
func createStars() -> void:
	for starIndex in range(numberOfStars):
		# Create star sprite.
		var newStar : Sprite2D = Sprite2D.new()
		newStar.texture = STAR_SPRITE
		starsParent.add_child(newStar)
		
		# Reposition star sprite randomly.
		var max_width_spawn : float = starsParent.size.x - STAR_SPRITE.get_width()
		var max_height_spawn : float = starsParent.size.y - STAR_SPRITE.get_height()
		var random_x_spawn_position : float = randf_range(STAR_SPRITE.get_width(), max_width_spawn)
		var random_y_spawn_position : float = randf_range(STAR_SPRITE.get_height(), max_height_spawn)
		newStar.position = Vector2(random_x_spawn_position, random_y_spawn_position)
