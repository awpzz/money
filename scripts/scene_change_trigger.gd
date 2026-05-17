extends Area3D

@export var scene_name: String

func enter_trigger(_body):
	call_deferred("_go_ending")

func _go_ending():
	get_tree().change_scene_to_file("res://escenas/ending.tscn")
