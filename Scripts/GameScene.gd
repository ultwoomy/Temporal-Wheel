# This class is to be extended by scene scripts.
extends Node
class_name GameScene


#@ Public Variables
var emoBuff : float = 1


#@ Virtual Methods
# Its inheriters should call this function with super._ready().
# Otherwise, this _ready function will get replaced and will be unable to run its functions.
func _ready() -> void:
	if(GVars.curEmotionBuff == 4):
		emoBuff = GVars.rustData.fourth
	
	WheelSpinner.wheelRotationCompleted.connect(on_wheel_spun)


#@ Public Methods
func on_wheel_spun() -> void:
	var temp = calcClick()
	if(GVars.ritualData.candlesLit[5]):
		GVars.kbityData.kbityAddSpin += temp


func calcClick() -> float:
	var temp
	var densityPower = GVars.spinData.density
	if(GVars.atlasData.dumpRustMilestone > 1):
		densityPower += GVars.atlasData.dumpRustMilestone/4 + 1
	if GVars.hasChallengeActive(GVars.CHALLENGE_SHARP):
		temp = pow(GVars.spinData.size,0.5)/log(GVars.spinData.rotations + 2)/2 * GVars.spinData.momentumPerClick  * densityPower * GVars.rustData.increaseMomentum * GVars.mushroomData.momentumBuff * GVars.Aspinbuff * emoBuff
	elif(GVars.curEmotionBuff == 2):
		temp = pow(GVars.spinData.size,GVars.spinData.density + 1) * GVars.spinData.momentumPerClick * densityPower * GVars.rustData.increaseMomentum * GVars.mushroomData.momentumBuff * GVars.Aspinbuff * emoBuff
	else:
		temp = GVars.spinData.momentumPerClick * GVars.spinData.size * densityPower * GVars.rustData.increaseMomentum * GVars.mushroomData.momentumBuff * GVars.Aspinbuff * emoBuff
	return temp


#@ Private Methods
func _changeScene(scenePath : String) -> void:
	SceneHandler.changeSceneToFilePath(scenePath)
