extends Area3D

@export var checkpoint_id := 0
var triggered := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	print("ENTRÓ EN CHECKPOINT:", checkpoint_id)
	if triggered:
		return

	if body.name == "player":
		triggered = true
		print("Checkpoint activado:", checkpoint_id)
