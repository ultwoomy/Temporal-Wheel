extends Node
class_name RustEmitter


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


func changeParticleOnRust(rustPerThresh : float = GVars.rustData.perThresh) -> void:
	if(rustPerThresh > 100000):
		particle.process_material.scale_min = 6.0
		particle.amount = 1
	elif(rustPerThresh > 10000):
		particle.process_material.scale_min = 5.0
		particle.amount = int(rustPerThresh/10000)
	elif(rustPerThresh > 1000):
		particle.process_material.scale_min = 4.0
		particle.amount = int(rustPerThresh/1000)
	elif(rustPerThresh > 100):
		particle.process_material.scale_min = 3.0
		particle.amount = int(rustPerThresh/100)
	elif(rustPerThresh > 10):
		particle.process_material.scale_min = 2.0
		particle.amount = int(rustPerThresh/10)
	else:
		particle.amount = int(rustPerThresh)
