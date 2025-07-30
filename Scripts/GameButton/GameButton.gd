extends Control
class_name GameButton


#@ Public Variables


#@ Private Variables
var _activeAnimation : GameButtonAnimation


#@ Onready Variables
@onready var audioStreamPlayer : AudioStreamPlayer = $AudioStreamPlayer


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Play animation depending on the animation script.
	if _activeAnimation:
		_activeAnimation.update(delta)


#@ Public Methods
# Every GameButton has this function associated with it.
# In order for it to play any animation, you must pass in a GameButtonAnimation derived class into the parameter. 
# With this function, it will play *any* GameButtonAnimation when called; just specify the GameButtonAnimation derived class.
func playAnimation(animation : GameButtonAnimation) -> void:
	# End any current animation.
	if _activeAnimation:
		_endAnimation()
	
	# Make sure the new animation can end when completed.
	# (!) Code can be adjusted so that it can repeat.
	animation.animationCompleted.connect(_endAnimation)
	
	# Set current animation to new animation.
	_activeAnimation = animation
	_activeAnimation.start()


# Create an increment label that only displays number in scientific notation.
func createIncrementLabel(value : float) -> IncrementLabel:
	var incrementLabel : IncrementLabel = IncrementLabel.new(value)
	var currentTree : SceneTree = get_tree()
	if currentTree:  # Avoids error when switching scenes at the same time of creating child.
		currentTree.current_scene.add_child(incrementLabel)
	return incrementLabel


func playSound(sound : AudioStream) -> void:
	# Error checking.
	if not audioStreamPlayer:
		printerr("ERROR: Unable to access audio stream player to play sound! Is the audio stream player a child of parent, ", self, "?")
		return
	
	audioStreamPlayer.stream = sound
	audioStreamPlayer.volume_db = GVars.sfxvol
	if not audioStreamPlayer.volume_db <= -24:
		audioStreamPlayer.play()


#@ Private Methods
# Tells the activeAnimation to stop playing.
func _endAnimation() -> void:
	_activeAnimation.exit()
	_activeAnimation = null
