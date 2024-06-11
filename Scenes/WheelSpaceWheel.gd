extends Node
class_name WheelSpaceWheel


#@ Constants
const RUST_PART = preload("res://Scenes/RustEmission.tscn")


#@ Global Variables
@onready var centerpiece : AnimatedSprite2D = $Centerpiece
@onready var ascensionButton : Button = $PreAscTransfer


#@ Public Methods
func updateWheelSprite() -> void:
	# Local Variables
	var frameNumber: int = GVars.spinData.wheelPhase - 1
	
	# Change sprite.
	if frameNumber > 11:
		centerpiece.frame = 11
	elif frameNumber < 0:
		centerpiece.frame = 0
	else:
		centerpiece.frame = frameNumber


# Creates rust instance which should occur when rust is gained.
func createRustInstance() -> void:
	var rus = RUST_PART.instantiate()
	rus.get_child(0).init(1)
	self.add_child(rus)	


'
# Rust related.
	if(GVars.rustData.threshProgress > GVars.rustData.thresh):
		if(GVars.curEmotionBuff == 4):
			emoBuff = log(GVars.spinData.rotations + 1) + 1
		if(GVars.hellChallengeNerf == 4):
			GVars.rustData.threshProgress -= GVars.rustData.thresh
			GVars.rustData.rust += 1
			GVars.rustData.thresh *= GVars.rustData.threshMult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(1)
			self.add_child(rus)	
		elif(GVars.sigilData.curSigilBuff == 1):
			GVars.rustData.threshProgress -= GVars.rustData.thresh
			GVars.rustData.rust += GVars.rustData.perThresh * 2 * emoBuff * fourthRustBuff
			GVars.rustData.thresh *= GVars.rustData.threshMult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(GVars.rustData.perThresh * 2 * emoBuff * fourthRustBuff)
			self.add_child(rus)
		else:
			GVars.rustData.threshProgress -= GVars.rustData.thresh
			GVars.rustData.rust += GVars.rustData.perThresh * emoBuff * fourthRustBuff
			GVars.rustData.thresh *= GVars.rustData.threshMult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(GVars.rustData.perThresh * emoBuff * fourthRustBuff)
			self.add_child(rus)	
	wheel.scale = Vector2(0.5 + log(GVars.spinData.size)/5,0.5 + log(GVars.spinData.size)/5)
'
