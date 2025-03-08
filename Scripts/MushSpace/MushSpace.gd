extends GameScene
class_name MushSpace


#@ Onready Variables
@onready var mushbot : Sprite2D = $Mushbot


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_showMushbot(Automation.contains("Mushbot"))  # If the Player has a Mushbot automator, then show the Mushbot.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#@ Public Methods


#@ Private Methods
func _showMushbot(condition : bool) -> void:
	if condition:
		mushbot.show()
	else:
		mushbot.hide()
