@tool
extends CollisionShape3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw3D.scoped_config().set_thickness(0.01).set_center_brightness(0.6)
	var mesh:ArrayMesh = self.shape.get_debug_mesh()
	
	# Every two faces is a line for debug_mesh
	for surface_idx in range(mesh.get_surface_count()):
		var surface_type = mesh.surface_get_primitive_type(0)
		var array:Array = mesh.surface_get_arrays(surface_idx)
		var vertices:PackedVector3Array = array[Mesh.ArrayType.ARRAY_VERTEX]
		var skip_next = false
		for vertex_idx in range(0, vertices.size() - 1, 2):
			if skip_next:
				skip_next = false
				continue
			var v1 = to_global(vertices[vertex_idx])
			var v2 = to_global(vertices[vertex_idx+1])
			if v1 == v2:
				skip_next = true
				continue
			DebugDraw3D.draw_line(v1, v2, Color.RED)

