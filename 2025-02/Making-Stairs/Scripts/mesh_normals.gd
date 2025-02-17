@tool
extends MeshInstance3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var array = self.mesh.surface_get_arrays(0)
	var position:PackedVector3Array = array[ArrayMesh.ARRAY_VERTEX]
	var normal:PackedVector3Array = array[ArrayMesh.ARRAY_NORMAL]
	
	for idx in range(position.size()):
		DebugDraw3D.draw_ray(position[idx], normal[idx], 0.1)
