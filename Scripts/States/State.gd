extends Resource
class_name State
# The State Pattern has some key features:
#	- The Context, a.k.a the script/node that has the State variable.
#		+ HAS: A function in the Context to change said State variable.
#	- The State, which has a reference to the Context.
#		+ REASONING: This allows the State to call the Context's change state function.
#		+ JUSTIFICATION:Concept of a Finite-State Machine; our states know which states
#						they can go into and which they can't... this then means
#						that the states are aware of each other.

# NOTE:	This class does NOT have a reference to the Context.
#		Therefore, derived State classes should have a reference variable to Context.


#@ Global Variables


#@ Functions
# Abstract Function: Called when first entering state.
func _enter() -> void:
	pass


# Abstract Function: Called continously when in state.
func _update(_delta: float) -> void:
	pass


# Abstract Function: Called when state is about to change.
func _exit() -> void:
	pass
