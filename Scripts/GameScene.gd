# This class is to be extended by scene scripts.
extends Node
class_name GameScene

var automators: Array[AutomatorData]

var event_manager: EventManager

var emoBuff : float = 1

#const SAVE_AUTOMATORS_PATH: String = "user://saveautomators.tres"

# Its inheriters should call this function with super._ready().
# Otherwise, this _ready function will get replaced and will be unable to run its functions.
func _ready() -> void:
	#run_tests()
	if(GVars.curEmotionBuff == 4):
		emoBuff = GVars.rustData.fourth
	# L.B:
	# When going to a new scene, this will create the event_manager and the automators (if any).
	# Therefore, must be important to save the elements in "automators" when transitioning to different stages.
	#	- Should probably have a new function here that handles transitions to another scene.
	#	- Will use the event_manager like "wheel_spun".
#	load_resources()

	create_event_manager()
	event_manager.wheel_spun.connect(on_wheel_spun)
	event_manager.reset_automators.connect(clear_automators)
	create_automators()


func run_tests() -> void:
	var automator_data: AutomatorData = load("res://Resources/Automator/Spinbot.tres")
	add_automator(automator_data)


#func load_new_scene(scene_path: String) -> void:
#	save_resources()
#	get_tree().change_scene_to_file(scene_path)


func on_wheel_spun() -> void:
	var sizePow = 1
	if(GVars.hellChallengeNerf == 2):
		sizePow = 0.5
	elif(GVars.curEmotionBuff == 2):
		sizePow = 2
	GVars.spin += GVars.spinPerClick * pow(GVars.size,sizePow) * GVars.density * GVars.rustData.increaseSpin * GVars.mushroomData.spinBuff * GVars.Aspinbuff * emoBuff


#func save_resources() -> void:
#	ResourceSaver.save(SAVE_AUTOMATORS_PATH, )


#func load_resources() -> Resource:
#	if ResourceLoader.exists(SAVE_AUTOMATORS_PATH):
#		return load(SAVE_AUTOMATORS_PATH)
#	return null


func create_event_manager() -> void:
	if(get_tree().root.get_node_or_null("EventManager")):
		event_manager = get_window().get_node("EventManager")
	else:
		event_manager = EventManager.new()
		event_manager.name = "EventManager"
		get_window().add_child.call_deferred(event_manager)


### AUTOMATORS, should probably create a "AutomatorManager" script instead of this.
# Creates automators using the "AutomatorData" that is in "automators".
func create_automators() -> void:
	# GameScenes will only create the automators it contains in its array.
	for automator_data in automators:
		# Check if automator already exists.
		if (get_tree().root.get_node_or_null(automator_data.name)):
			continue
		
		# If does not exist, make a new one.
		match(automator_data.automator):
			AutomatorData.Automators.Spinbot:
				var spinbot: Spinbot = Spinbot.new(automator_data)
				spinbot.name = automator_data.name
				# Add to the root of the tree, so that creating a new scene does not delete the automator.
				get_window().add_child.call_deferred(spinbot)
			
			AutomatorData.Automators.Mushroombot:
				# WIP
				pass
			
			_:
				printerr("ERROR: Unknown automator assigned in ", automator_data, "!")
				return


# Add automator to the array if not already in it.
func add_automator(automator: AutomatorData) -> void:
	if automator in automators:
		return
	automators.append(automator)


func clear_automators() -> void:
	for automator_data in automators:
		if (get_tree().root.get_node_or_null(automator_data.name)):
			get_tree().root.get_node_or_null(automator_data.name).queue_free()
	automators.clear()
	
