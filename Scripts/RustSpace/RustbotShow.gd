extends TextureButton
@onready var selectionMenu : Control = $SelectionMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	selectionMenu.rustbotSelectionPressed.connect(_onSelect)
	if Automation.contains("Rustbot"):
		show()
	else:
		hide()
	selectionMenu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if selectionMenu.is_visible_in_tree():
		selectionMenu.hide()
	else:
		selectionMenu.show()

func _onSelect():
	selectionMenu.hide()
