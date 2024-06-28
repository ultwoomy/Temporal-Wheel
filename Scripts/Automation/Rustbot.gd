extends Automator
class_name Rustbot


#@ Public Variables


#@ Virtual Methods
func _execute() -> void:
	# Automator has to be enabled to execute.
	if not enabled or not GVars.automatorVarsData.rustAutoBuyEnabled:
		return
	print("suc")
	_up04()
	_up03()
	_up02()
	_up01()
	
func getType() -> String:
	return "Rustbot"
	
func _up01():
	if(GVars.rustData.rust >= GVars.rustData.increaseSpinCost):
		GVars.rustData.rust -= GVars.rustData.increaseSpinCost
		GVars.rustData.increaseSpinCost *= GVars.rustData.increaseSpinScaling
		GVars.rustData.increaseSpin += 1


func _up02():
	if(GVars.rustData.rust >= GVars.rustData.increaseHungerCost):
		GVars.rustData.rust -= GVars.rustData.increaseHungerCost
		GVars.rustData.increaseHungerCost *= GVars.rustData.increaseHungerScaling
		GVars.rustData.increaseHunger += 1


func _up03():
	if(GVars.rustData.rust >= GVars.rustData.increaseRustCost):
		GVars.rustData.rust -= GVars.rustData.increaseRustCost
		GVars.rustData.increaseRustCost *= GVars.rustData.increaseRustScaling
		GVars.rustData.increaseRust += 1
		GVars.rustData.perThresh += 1


func _up04():
	if(GVars.rustData.rust >= GVars.rustData.fourthCost):
		GVars.rustData.rust -= GVars.rustData.fourthCost
		GVars.rustData.fourthCost *= GVars.rustData.fourthScaling
		if(GVars.curEmotionBuff == 1):
		#fear
			GVars.rustData.fourth += 0.03
		elif(GVars.curEmotionBuff == 2):
		#cold
			GVars.rustData.fourth += 0.02
		elif(GVars.curEmotionBuff == 3):
		#warmth
			GVars.rustData.fourth *= 1.5
		elif(GVars.curEmotionBuff == 4):
		#wrath
			GVars.rustData.fourth *= 1.2

