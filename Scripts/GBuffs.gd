extends Node
# Autoload script.
# Runs calculations for buffs.


#@ Global Variables
var spinGainModifier : float = 1.0
var rustGainModifier : float = 1.0
var mushroomPendingRotationModifier : float = 1.0
var wheelRotationGainModifier : float = 1.0
var dollarRotationModifier : float = 1.0

func _ready() -> void:
	EventManager.refresh_augment_buffs.connect(self.augmentSigilBuffs)

#@ Public Methods
func augmentSigilBuffs() -> void:
	reset_buffs()
	if GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_PACKSMITH:  # Packsmith sigil
		# Rust gain doubled.
		rustGainModifier = 2.0
	elif GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_CANDLE:  # Candle sigil
		# Mushrooms grow 1.5x as fast.
		mushroomPendingRotationModifier = 1.5
	elif GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_ASCENSION:
		pass
	elif GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_EMPTINESS:
		pass
	elif GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_RITUAL:
		pass
	elif GVars.sigilData.currentAugmentedSigil == GVars.SIGIL_HELL:
		pass
	## TODO:
	#elif GVars.sigilData.currentAugmentedSigil == 9:
		#dollarRotationModifier = 1 + (GVars.dollarData.sandDollars / 25)
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
	dollarRotationModifier = 1
