extends Node

@export var spinPerCDisplay: Label
@export var button: Button

var fmat = preload("res://Scripts/FormatNo.gd")


func _ready():
	save_loop()
	spin_update_loop()
	# L.B: Since clicking on the button adds to spin, this can be kept here.
	# ...However, you can also have it in its own script w/ the function
	# ...OR have the button call the function here.
	# ...OR have the button signal to somewhere to add to spin (so other things can add to it as well)
	button.size = Vector2(200,100)
	button.text = "Spin"
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)
	await get_tree().create_timer(0.1).timeout
	var event_manager: EventManager = get_window().get_node("EventManager")
	event_manager.emit_signal("scene_change",true)

# L.B: Probably just use a signal in a different script so all things can add to spin.
func _button_pressed():
	# L.B: Can also use get_tree().root.get_node(...) I believe.
	var event_manager: EventManager = get_window().get_node("EventManager")
	event_manager.wheel_spun.emit()
	
	
#	GVars.spin += GVars.spinPerClick * GVars.size * GVars.density * GVars.Rincreasespin * GVars.Sspinbuff


#	L.B: This line of code is being commented out since it isn't needed (since SpinDisplay has it in its _process() function)
#	...If you want to change the text only when necessary, use signals instead of assigning the Node to a variable.
#	...Ex: Call a signal when GVars.spin changes.
#	spinDisplay.text = str(GVars.getScientific(GVars.spin))

func spin_update_loop():
	spinPerCDisplay.text = str(GVars.getScientific(GVars.spinData.spinPerClick))
	await get_tree().create_timer(0.1).timeout
	spin_update_loop()


func save_loop():
	GVars.save_prog()
	await get_tree().create_timer(20).timeout
	save_loop()
