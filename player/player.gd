extends CharacterBody3D


var SPEED = 3.0
@export var footstep_sounds: Array[AudioStream]
@export var grass_sounds: Array[AudioStream]
@onready var rng = RandomNumberGenerator.new()
@onready var headbob_anim = get_node("head/AnimationPlayer")

var dead = false

func die():
	if dead:
		return
	dead = true

	# parar movimiento
	set_physics_process(false)

	# avisar UI
	$player_ui.show_death()

var floor_type = 0

var crouching = false

func _ready() -> void :
	headbob_anim.play("walk")

func footsteps(sound_array, min_range, max_range):
	if !$feet.playing:
		$feet.pitch_scale = rng.randf_range(min_range, max_range)
		$feet.stream = sound_array[rng.randi_range(0, sound_array.size() - 1)]
		$feet.play()

func _process(_delta: float) -> void :
	if Input.is_action_just_pressed("crouch"):
		crouching = !crouching
	if crouching and SPEED != 1.25:
		SPEED = 1.25
	if !crouching and SPEED != 3.5:
		SPEED = 3.5

func headbob(value: float):
	if headbob_anim.speed_scale != value:
		headbob_anim.speed_scale = value

func _physics_process(delta: float) -> void :
	if crouching and $CollisionShape3D.shape.height > 0.25:
		var crouch_height = lerp($CollisionShape3D.shape.height, 0.25, 0.2)
		$CollisionShape3D.shape.height = crouch_height
	if !crouching and $CollisionShape3D.shape.height < 2.0:
		var crouch_height = lerp($CollisionShape3D.shape.height, 2.0, 0.2)
		$CollisionShape3D.shape.height = crouch_height

	if not is_on_floor():
		velocity += get_gravity() * delta


	var input_dir: = Input.get_vector("left", "right", "forward", "backward")
	var direction: = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			headbob(2.0)
			if floor_type == 0:
				footsteps(footstep_sounds, 0.8, 1.1)
			elif floor_type == 1:
				footsteps(grass_sounds, 1.3, 1.6)
		else:
			headbob(0.0)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		headbob(0.0)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
