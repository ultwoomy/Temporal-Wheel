extends Control
@export var bleedbarforeground : AnimatedSprite2D
@export var bleedbarbackground : AnimatedSprite2D
@export var bleedEmitter : BleedEmitter
# Called when the node enters the scene tree for the first time.
func _ready():
	if not GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS):
		hide()
		set_process(false)
	else:
		WheelSpinner.wheelRotationCompleted.connect(self.bleed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bleedbarforeground.frame = GVars.bleedstacks - 1
	bleedbarbackground.frame = GVars.bleedstacks
	bleedbarforeground.modulate = Color(1,1,1,(160.0 - float(GVars.health))/160)

func bleed():
	bleedEmitter.changeParticleAmt(GVars.bleedstacks * 2)
	bleedEmitter.emit()
	bleedEmitter.emit_somewhere(Vector2(-100,0))
	bleedEmitter.emit_somewhere(Vector2(100,0))
	GVars.spinData.spin -= (GVars.spinData.spin/200 * GVars.bleedstacks)
