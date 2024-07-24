extends State
class_name HSCM_State


#@ Public Variables
var contractMenu : ContractMenu


#@ Virtual Methods
# Requires HellSpaceContracts to be initialized with a reference to PacksmithMenu.
func _init(_contractMenu : ContractMenu) -> void:
	contractMenu = _contractMenu
