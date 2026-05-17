extends CanvasLayer

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://levels/level.tscn")

func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
