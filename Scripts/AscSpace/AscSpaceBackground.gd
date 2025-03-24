extends AnimatedSprite2D


#@ Export Variables


#@ Public Variables


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	fadeInFromBlack()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#@ Public Methods
func fadeInFromBlack() -> void:
	const maxFrames : int = 200
	var frames : int = 0
	
	while frames < maxFrames:
		frames += 1
		var colorValue : float = float(frames) / 200.0
		self.modulate = Color(colorValue, colorValue, colorValue)
		if get_tree() != null:
			await get_tree().process_frame  # Wait a frame before continuing while loop again.


func playAnimation() -> void:
	const maxFrames : int = 2100
	var frames : int = 0
	
	while frames < maxFrames:
		frames += 1
		var scaleValue : float = float(frames + 300) / 300.0
		self.scale = Vector2(scaleValue, scaleValue)
		if get_tree() != null:
			await get_tree().process_frame


#@ Private Methods
