# The EventManager.gd handles signals using the Observer pattern.
# It is a singleton that all scripts/classes can access if using signals.
# Causes coupling (tons of connections like a web), however it is fine in this case.
extends Node

# This is how the EventManager.gd works:
#	1. A signal is made in EventManager.gd
#		- Ex. "signal wheel_spun"

#	2. The signal is connected by one or more scripts. Say we have two such scripts called "connector"
#		- Ex. Both "connector" scripts would have:
#				EventManager.wheel_spun.connect("some_method_in_the_connector_script")

#	3. The signal is emitted in one or more scripts. Say we have one such script called "emitter".
#		- Ex. The "emitter" script would have:
#				EventManager.wheel_spun.emit()

signal wheel_spun
signal scene_change

# MushSpace
# (!) L.B: If things get too big, should probably make another script to hold and categorize signals to be used in this script.
signal mushroom_frame_changed(index: int)
signal mushroom_planted
signal mushroom_harvested
