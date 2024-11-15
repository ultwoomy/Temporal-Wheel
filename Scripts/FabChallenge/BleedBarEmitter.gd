extends Node
class_name BleedEmitter


#@ Onready Variables
@onready var particle : GPUParticles2D = $GPUParticles2D


#@ Virtual Methods
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass


#@ Public Methods
# Should be called when rust has been gained.
func emit() -> void:
	if not particle.emitting:
		particle.restart()
		
func emit_somewhere(xy : Vector2):
	particle.position = xy
	emit()
	particle.position = Vector2(0,0)


func changeParticleAmt(x) -> void:
	if x < 1:
		x = 1
	particle.amount = x
