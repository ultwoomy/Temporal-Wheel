extends SigilStrategy
class_name PacksmithSigilStrategy


#@ Virtual Methods
## The Packsmith sigil, once augmented, has something to do with rust gain.
## Therefore, the Packsmith Sigil Strategy will communicate with rust gain.
func _execute() -> void:
	WheelSpinner.buffRustGain(RustGainPacksmithStrategy.new(), WheelSpinner.RustGainOperationOrder.LAST)


func _exit() -> void:
	WheelSpinner.removeRustGainBuff(RustGainPacksmithStrategy.new())
