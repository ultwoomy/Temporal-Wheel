extends Panel
signal confirmed
signal failed
@export var body : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	connect("confirmed",body.confirmTrue)
	connect("failed",body.confirmFalse)


func ask():
	show()

func _on_yes_pressed():
	emit_signal("confirmed")
	hide()


func _on_no_pressed():
	emit_signal("failed")
	hide()
