extends RustGainStrategy
class_name RustGainPacksmithStrategy
## This strategy is gained from augmenting the Packsmith sigil.


#@ Constants
const BUFF_MODIFIER : float = 2.0


#@ Virtual Methods
## Packsmith Augment doubles the amount of rust gain.
##  Therefore, this rust gain strategy should be done before any other strategy.
func _applyBuff(rustValue : float) -> float:
	var result : float = rustValue * BUFF_MODIFIER
	return result
