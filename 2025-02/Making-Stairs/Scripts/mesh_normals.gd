@tool
extends MeshInstance3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw3D.scoped_config().set_thickness(0.01).set_center_brightness(0.6)
	var array = self.mesh.surface_get_arrays(0)
	var position:PackedVector3Array = array[ArrayMesh.ARRAY_VERTEX]
	var normal:PackedVector3Array = array[ArrayMesh.ARRAY_NORMAL]
	
	for idx in range(position.size()):
		DebugDraw3D.draw_arrow_ray(to_global(position[idx]), to_global(normal[idx]).normalized(), 0.1, Color(0.0, 0.5, 0.0, 0.25), 0.05)
