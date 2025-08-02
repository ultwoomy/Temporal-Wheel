extends Control
class_name WheelSpaceBackground


#@ Constants
const STAR : Resource = preload("res://Scenes/WheelSpace/WheelSpaceStar.tscn")
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
		# Create star.
		var newStar : WheelSpaceStar = STAR.instantiate()
		starsParent.add_child(newStar)
		
		# Reposition star sprite randomly on created and when finished blinking.
		_repositionStar(newStar)
		newStar.blinkFinished.connect(_repositionStar)
		
		# Randomize size of star.
		newStar.randomizeLook()


#@ Private Methods
func _repositionStar(star : WheelSpaceStar) -> void:
	var max_width_spawn : float = starsParent.size.x - star.get_rect().size.x
	var max_height_spawn : float = starsParent.size.y - star.get_rect().size.y
	var random_x_spawn_position : float = randf_range(star.get_rect().size.x, max_width_spawn)
	var random_y_spawn_position : float = randf_range(star.get_rect().size.y, max_height_spawn)
	star.position = Vector2(random_x_spawn_position, random_y_spawn_position)
