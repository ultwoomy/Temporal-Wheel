extends Control
class_name GameButton


#@ Public Variables


#@ Private Variables
var _activeAnimation : GameButtonAnimation


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


# Display a text message of the increment value from pressing the game button.
func displayIncrement(value) -> void:
	var mousePosition : Vector2 = get_global_mouse_position()
	
	# Create instance of text.
	var incrementValueLabel : IncrementValueLabel = IncrementValueLabel.new(value)
	incrementValueLabel.position = mousePosition
	get_tree().current_scene.add_child(incrementValueLabel)


#@ Private Methods
# Tells the activeAnimation to stop playing.
func _endAnimation() -> void:
	_activeAnimation.exit()
	_activeAnimation = null
