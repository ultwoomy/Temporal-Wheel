extends Node
# Autoload script.
# Runs calculations for buffs.


#@ Global Variables
var mushroomPendingRotationModifier : float = 1.0


#@ Public Methods
func augmentSigilBuffs() -> void:
	if GVars.sigilData.curSigilBuff == 1:
		pass
	elif GVars.sigilData.curSigilBuff == 2:  # Candle sigil
		# Mushrooms grow twice as fast.
		mushroomPendingRotationModifier *= 2.0
	elif GVars.sigilData.curSigilBuff == 3:
		pass
	elif GVars.sigilData.curSigilBuff == 4:
		pass
	elif GVars.sigilData.curSigilBuff == 5:
		pass
	elif GVars.sigilData.curSigilBuff == 6:
		pass
	else:
		printerr("ERROR: Sigil buff not implemented!")
		return

#@ Private Methods
