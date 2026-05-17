extends Control

func _ready() -> void :
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# var save = FileAccess.open("user://checkpoint.skibidi", FileAccess.READ)
	# if save:
		# $main / Button2.disabled = false
		# save.close()

func continue_game():
	$interact.play()
	await get_tree().create_timer(0.5, true).timeout
	get_tree().change_scene_to_file("res://levels/level.tscn")

func new_game():
	$interact.play()
	$main.visible = false
	$are_you_sure.visible = true

func play_hover():
	$hover.play()

func confirm_yes():
	$interact.play()
	# DirAccess.remove_absolute("user://checkpoint.skibidi")
	# await get_tree().create_timer(0.5, true).timeout
	# get_tree().change_scene_to_file("res://ui/story.tscn")

func confirm_no():
	$interact.play()
	$main.visible = true
	$are_you_sure.visible = false
	$settings.visible = false
	$controls.visible = false
	$credits.visible = false

func quit_game():
	$interact.play()
	await get_tree().create_timer(0.5, true).timeout
	get_tree().quit()

func open_credits():
	$interact.play()
	$main.visible = false
	$credits.visible = true

func open_settings():
	$interact.play()
	$settings.visible = true
	$main.visible = false

func open_controls():
	$interact.play()
	$main.visible = false
	$controls.visible = true
