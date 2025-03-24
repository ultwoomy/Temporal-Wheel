extends Node
# Autoload script.
# Runs calculations for buffs.


#@ Global Variables
var spinGainModifier : float = 1.0
var rustGainModifier : float = 1.0
var mushroomPendingRotationModifier : float = 1.0
var wheelRotationGainModifier : float = 1.0


#@ Public Methods
func augmentSigilBuffs() -> void:
	reset_buffs()
	if GVars.sigilData.curSigilBuff == 0:  # Packsmith sigil
		# Rust gain doubled.
		rustGainModifier = 2.0
	elif GVars.sigilData.curSigilBuff == 1:  # Candle sigil
		# Mushrooms grow 1.5x as fast.
		mushroomPendingRotationModifier = 1.5
	elif GVars.sigilData.curSigilBuff == 2:
		pass
	elif GVars.sigilData.curSigilBuff == 3:
		pass
	elif GVars.sigilData.curSigilBuff == 4:
		pass
	elif GVars.sigilData.curSigilBuff == 5:
		pass
	else:
		printerr("ERROR: Sigil buff not implemented!")
		return


func applyEmotionBuffs() -> void:
	if GVars.curEmotionBuff == 1:  # 
		# Increase rotation gain.
		wheelRotationGainModifier = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
	elif GVars.curEmotionBuff == 2:  # 
		pass
	elif GVars.curEmotionBuff == 3:  # 
		pass
	elif GVars.curEmotionBuff == 4:  # 
		# Increase rust gain.
		# Base emotion buff.
		rustGainModifier = (log(GVars.spinData.rotations + 1) + 1) * GVars.rustData.fourth * (GVars.atlasData.dumpRustMilestone + 1)
		print(rustGainModifier)
		# Packsmith upgrade which only works if curEmotionBuff == 4.
	elif GVars.curEmotionBuff == 5:  # 
		pass
	else:
		return


#@ Private Methods
func reset_buffs():
	rustGainModifier = 1
	mushroomPendingRotationModifier = 1
