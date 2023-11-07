extends Node

func _init():
	if(GVars.Rperthresh > 100000):
		self.process_material.scale_min = 6.0
		self.amount = 1
	elif(GVars.Rperthresh > 10000):
		self.process_material.scale_min = 5.0
		self.amount = int(GVars.Rperthresh/10000)
	elif(GVars.Rperthresh > 1000):
		self.process_material.scale_min = 4.0
		self.amount = int(GVars.Rperthresh/1000)
	elif(GVars.Rperthresh > 100):
		self.process_material.scale_min = 3.0
		self.amount = int(GVars.Rperthresh/100)
	elif(GVars.Rperthresh > 10):
		self.process_material.scale_min = 2.0
		self.amount = int(GVars.Rperthresh/10)
	else :
		self.amount = int(GVars.Rperthresh)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(!self.emitting):
		queue_free()
