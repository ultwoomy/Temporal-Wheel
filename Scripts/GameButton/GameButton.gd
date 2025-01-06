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
func playAnimation(animation : GameButtonAnimation) -> void:
	# End any current animation.
	if _activeAnimation:
		_endAnimation()
	
	# Make sure animation can end when completed.
	animation.animationCompleted.connect(_endAnimation)
	
	# Set animation to new animation.
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
func _endAnimation() -> void:
	_activeAnimation.exit()
	_activeAnimation = null
