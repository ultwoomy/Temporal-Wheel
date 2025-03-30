extends Control
class_name MushInfoPanel


#@ Global Variables


#@ Onready Variables
@onready var mushroomSprite : Sprite2D = $MushroomSprite
@onready var descriptionLabel : Label = $MushDescription
@onready var leftArrowButton : Button = $LeftArrow
@onready var rightArrowButton : Button = $RightArrow


#@ Public Variables


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func displayMushroomCropInfo(mushroomCrop : MushroomCrop) -> void:
	# Display mushroom sprite.
	mushroomSprite.texture = load(mushroomCrop.spritePath)
	
	# Display name and description of the selected crop.
	descriptionLabel.text = mushroomCrop.name + "\n"
	descriptionLabel.text += mushroomCrop.description


#@ Private Methods
