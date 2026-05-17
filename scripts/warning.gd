extends Control

@export var wait_time: float = 1.0
@export var scene_path: String

func _ready() -> void:
	if has_node("CanvasLayer/AnimationPlayer"):
		$CanvasLayer/AnimationPlayer.play("fade")

	await get_tree().create_timer(wait_time).timeout

	if scene_path != "" and ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("ERROR: scene_path no válido -> ", scene_path)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if scene_path != "":
			get_tree().change_scene_to_file(scene_path)
