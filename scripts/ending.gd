extends Area3D

var triggered := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node) -> void:
	if triggered:
		return

	if _body.name == "player":
		triggered = true
		call_deferred("_ending")


func _ending() -> void:
	var tree = get_tree()
	tree.paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	print("Conseguiste escapar... Por ahora...")

	await tree.create_timer(3.0).timeout
	tree.quit()
