# This class is to be extended by scene scripts.
extends Node
class_name GameScene

var automators: Array[Automator]

var event_manager: EventManager

#const SAVE_AUTOMATORS_PATH: String = "user://saveautomators.tres"

# Its inheriters should call this function with super._ready().
# Otherwise, this _ready function will get replaced and will be unable to run its functions.
func _ready() -> void:
#	load_resources()

	create_event_manager()
	event_manager.wheel_spun.connect(on_wheel_spun)
	create_automators()


#func load_new_scene(scene_path: String) -> void:
#	save_resources()
#	get_tree().change_scene_to_file(scene_path)


func on_wheel_spun() -> void:
	GVars.spin += GVars.spinPerClick * GVars.size * GVars.density * GVars.Rincreasespin * GVars.Sspinbuff


#func save_resources() -> void:
#	ResourceSaver.save(SAVE_AUTOMATORS_PATH, )


#func load_resources() -> Resource:
#	if ResourceLoader.exists(SAVE_AUTOMATORS_PATH):
#		return load(SAVE_AUTOMATORS_PATH)
#	return null


func create_event_manager() -> void:
	event_manager = EventManager.new()
	event_manager.name = "EventManager"
	add_child(event_manager)


func create_automators() -> void:
	pass
