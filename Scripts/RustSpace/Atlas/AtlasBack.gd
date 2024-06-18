extends TextureButton


func _ready() -> void:
	pressed.connect(self._on_pressed)


func _on_pressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.RUSTSPACE_OUTSIDE)
