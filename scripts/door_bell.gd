extends Node3D

var times_rung = 0
#@export var door: Node3D
@onready var ui = get_tree().current_scene.get_node("player/player_ui")

# func _ready() -> void :
	# var save = FileAccess.open("user://checkpoint.skibidi", FileAccess.READ)
	# if !save:
		# door.locked = true
	# elif save:
		# door.locked = false
		# times_rung = 2
		# save.close()

func ring_bell():
	if $AnimationPlayer.current_animation != "press" and times_rung < 2:
		$button.play()
		times_rung += 1
		$AnimationPlayer.play("press")
		await get_tree().create_timer(0.5, false).timeout
		$door_bell2.play()
		if times_rung >= 2:
			await get_tree().create_timer(4.0, false).timeout
			ui.set_task("Entra en la casa")
			# door.locked = false
