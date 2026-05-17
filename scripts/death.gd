extends Control



func _ready() -> void :
	$AnimationPlayer.play("death")
	await get_tree().create_timer(5.5, true).timeout
	get_tree().change_scene_to_file("res://levels/level.tscn")
