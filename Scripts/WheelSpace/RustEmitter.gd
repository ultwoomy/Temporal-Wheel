extends Node
class_name RustEmitter


#@ Onready Variables
@onready var particle : GPUParticles2D = $GPUParticles2D


#@ Virtual Methods
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	# OLD CODE: Originally created an instance, played the effect, then deleted itself afterwards.
#	if not particle.emitting:
#		queue_free()
	pass


#@ Public Methods
# Should be called when rust has been gained.
func emit() -> void:
	particle.restart()


func init(Rperthresh = GVars.rustData.perThresh):
	if(Rperthresh > 100000):
		particle.process_material.scale_min = 6.0
		particle.amount = 1
	elif(Rperthresh > 10000):
		particle.process_material.scale_min = 5.0
		particle.amount = int(Rperthresh/10000)
	elif(Rperthresh > 1000):
		particle.process_material.scale_min = 4.0
		particle.amount = int(Rperthresh/1000)
	elif(Rperthresh > 100):
		particle.process_material.scale_min = 3.0
		particle.amount = int(Rperthresh/100)
	elif(Rperthresh > 10):
		particle.process_material.scale_min = 2.0
		particle.amount = int(Rperthresh/10)
	else :
		particle.amount = int(Rperthresh)
