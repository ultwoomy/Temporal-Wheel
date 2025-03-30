extends Node
class_name MushFarmButtons


#@ Signals


#@ Onready Variables
# Buttons to be connected by other classes.
@onready var plantButton : Button = $PlantButton
@onready var harvestButton : Button = $HarvestButton
@onready var removeButton : Button = $DeleteButton


#@ Public Variables


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## L.B: What is this for?
	GVars.mushroomData.fearMushBuff = 1


#@ Public Methods
