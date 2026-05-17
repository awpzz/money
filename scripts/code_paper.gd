extends RigidBody3D

@export var positions: Array[Node3D]
@export var door: Node3D

@onready var rng := RandomNumberGenerator.new()
@onready var pickup_sound := get_tree().current_scene.get_node_or_null("key_pickup")

var pos_obj: Node3D = null
var picked := false


func _ready() -> void:
	if positions.size() == 0:
		print("ERROR: no hay posiciones")
		return

	var chance := rng.randi_range(0, positions.size() - 1)
	global_transform.origin = positions[chance].global_transform.origin

	print("Key spawn:", chance)

	# SI el nombre no coincide, ocúltalo (debug antiguo)
	if name != "key":
		visible = false


func hit_obj(body: Node3D) -> void:
	pos_obj = body
	freeze = true


func pickup_key() -> void:
	if picked:
		return

	picked = true

	print("KEY PICKED")

	# sonido seguro
	if pickup_sound:
		pickup_sound.play()

	# desbloquear puerta de forma segura
	if is_instance_valid(door):
		if "locked" in door:
			door.locked = false
		elif door.has_method("unlock"):
			door.unlock()
	else:
		print("WARNING: door no asignada")

	queue_free()


func _physics_process(_delta: float) -> void:
	if pos_obj:
		global_transform.origin = pos_obj.global_transform.origin
