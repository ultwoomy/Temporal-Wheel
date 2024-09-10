extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var ratio = 1
	if GVars.fearcatData.bankedNightRots <= GVars.fearcatData.bankedDayRots:
		ratio = (GVars.fearcatData.bankedNightRots / GVars.fearcatData.bankedDayRots)/4 + 0.75
	else:
		ratio = (GVars.fearcatData.bankedNightRots / GVars.fearcatData.bankedDayRots)/4 + 0.75
	if GVars.ifSecondBoot % 4 == 3 or GVars.ifSecondBoot % 4 == 0:
		GVars.fearcatData.fearcatBuffNight = 1 + (GVars.fearcatData.bankedNightRots * GVars.Aspinbuff/50000) * ratio
	else:
		GVars.fearcatData.fearcatBuffDay = GVars.fearcatData.bankedDayRots * GVars.Aspinbuff/3500 * ratio


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var setText = str(GVars.getScientific(GVars.fearcatData.bankedDayRots)) + "/" + str(GVars.getScientific(GVars.fearcatData.bankedNightRots)) + " rotations\nCurrent time: \n"
	if GVars.ifSecondBoot % 4 == 3 or GVars.ifSecondBoot % 4 == 0:
		setText += "Night\nEffect: " + str(GVars.getScientific(GVars.fearcatData.fearcatBuffNight)) + " rotation speed multiplier."
	else:
		setText += "Day\nEffect: " + str(GVars.getScientific(GVars.fearcatData.fearcatBuffDay)) + " extra mushroom xp per harvest."
	text = setText
