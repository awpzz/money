extends RayCast3D

func _physics_process(_delta: float) -> void :
	if is_colliding():
		var hit = get_collider()
		if "grass" in hit.name:
			if get_parent().floor_type != 1:
				get_parent().floor_type = 1
		else:
			if get_parent().floor_type != 0:
				get_parent().floor_type = 0
	else:
		if get_parent().floor_type != 2:
			get_parent().floor_type = 2
