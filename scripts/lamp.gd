extends Node3D

@export var on := false
@export var on_mat: StandardMaterial3D
@export var off_mat: StandardMaterial3D
@export var light_color: Color

@onready var reflection_probe: ReflectionProbe = get_node_or_null("ReflectionProbe")
@onready var omni_light: OmniLight3D = $OmniLight3D
@onready var lamp_head: MeshInstance3D = $lamp_head
@onready var sound: AudioStreamPlayer3D = $sound


func _ready() -> void:
	omni_light.light_color = light_color

	_apply_state()


func _apply_state() -> void:
	lamp_head.material_override = on_mat if on else off_mat
	omni_light.visible = on


func toggle_light() -> void:
	on = !on

	# sonido
	sound.pitch_scale = 1.0 if on else 0.8
	sound.play()

	_apply_state()

	# ❌ NO CRASH SAFE (solo si existe)
	if reflection_probe:
		# aquí NO tocamos origin_offset porque no es fiable en Godot 4
		reflection_probe.update_mode = ReflectionProbe.UPDATE_ONCE
