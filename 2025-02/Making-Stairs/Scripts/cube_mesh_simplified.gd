extends MeshInstance3D

func _add_face(st:SurfaceTool, _v1:Vector3, _v2:Vector3, _v3:Vector3, _v4:Vector3) -> void:
	# first triangle
	st.add_vertex(_v1)
	st.add_vertex(_v3)
	st.add_vertex(_v2)

	# second triangle
	st.add_vertex(_v2)
	st.add_vertex(_v3)
	st.add_vertex(_v4)

# Create a cube and provide it to this mesh instance.
func _ready():
	# Start creating a new mesh with SurfaceTool
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	# Points for the cube
	var v1:Vector3 = Vector3(0, 0, 0)
	var v2:Vector3 = Vector3(0, 0, 1)
	var v3:Vector3 = Vector3(0, 1, 0)
	var v4:Vector3 = Vector3(0, 1, 1)
	var v5:Vector3 = Vector3(1, 0, 0)
	var v6:Vector3 = Vector3(1, 0, 1)
	var v7:Vector3 = Vector3(1, 1, 0)
	var v8:Vector3 = Vector3(1, 1, 1)

	# faces (using helper function)
	_add_face(st, v1, v2, v3, v4) # front face
	_add_face(st, v5, v7, v6, v8) # back face
	_add_face(st, v1, v3, v5, v7) # left face
	_add_face(st, v2, v6, v4, v8) # right face
	_add_face(st, v3, v4, v7, v8) # top face
	_add_face(st, v1, v5, v2, v6) # bottom face

	# Create normals for the mesh and provide to instance.
	st.generate_normals()
	self.mesh = st.commit();
