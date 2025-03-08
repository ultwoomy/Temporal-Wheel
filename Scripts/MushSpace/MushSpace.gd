extends GameScene
class_name MushSpace


#@ Signals


#@ Onready Variables
@onready var background : Sprite2D = $Background
@onready var mushRoom : AnimatedSprite2D = $MushRoom
@onready var mushbot : Sprite2D = $Mushbot

@onready var farmPlots : MushFarmPlots = $FarmPlots
@onready var infoPanel : MushInfoPanel = $InfoPanel
@onready var farmButtons : MushFarmButtons = $FarmButtons
@onready var levelDisplay : MushLevelDisplay = $LevelDisplay
@onready var statsPanel : MushStatsPanel = $StatsPanel

@onready var backButton : Button = $BackButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setMushbotVisibility(Automation.contains("Mushbot"))  # If the Player has a Mushbot automator, then show the Mushbot.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#@ Public Methods


#@ Private Methods
func _setMushbotVisibility(condition : bool) -> void:
	mushbot.visible = condition
