# This class is to be extended by scene scripts.
extends Node
class_name GameScene


#@ Public Variables
var emoBuff : float = 1


#@ Virtual Methods
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
	
	EventManager.wheel_spun.connect(on_wheel_spun)


#@ Public Methods
#func load_new_scene(scene_path: String) -> void:
#	save_resources()
#	get_tree().change_scene_to_file(scene_path)


func on_wheel_spun() -> void:
	var temp = calcClick()
	if(GVars.ritualData.candlesLit[5]):
		GVars.kbityData.kbityAddSpin += temp
	GVars.spinData.spin += temp


func calcClick() -> float:
	var temp
	var densityPower = GVars.spinData.density
	if(GVars.atlasData.dumpRustMilestone > 1):
		densityPower += GVars.atlasData.dumpRustMilestone/4 + 1
	if(GVars.hellChallengeNerf == 2):
		temp = pow(GVars.spinData.size,0.5)/log(GVars.spinData.rotations + 2)/2 * GVars.spinData.spinPerClick  * densityPower * GVars.rustData.increaseSpin * GVars.mushroomData.spinBuff * GVars.Aspinbuff * emoBuff
	elif(GVars.curEmotionBuff == 2):
		temp = pow(GVars.spinData.size,GVars.spinData.density + 1) * GVars.spinData.spinPerClick * densityPower * GVars.rustData.increaseSpin * GVars.mushroomData.spinBuff * GVars.Aspinbuff * emoBuff
	else:
		temp = GVars.spinData.spinPerClick * GVars.spinData.size * densityPower * GVars.rustData.increaseSpin * GVars.mushroomData.spinBuff * GVars.Aspinbuff * emoBuff
	return temp
