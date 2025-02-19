extends MeshInstance3D

# Create a square and provide it to this mesh instance.
func _ready():
	# Start creating a new mesh with SurfaceTool
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	# Points for the square
	var v1:Vector3 = Vector3(-1, -1, 0)
	var v2:Vector3 = Vector3(-1, 1, 0)
	var v3:Vector3 = Vector3(1, 1, 0)
	var v4:Vector3 = Vector3(1, -1, 0)

	# create a triangle by adding v1, v2, v3.
	st.add_vertex(v1)
	st.add_vertex(v2)
	st.add_vertex(v3)

	# create a second triangle by adding v3, v4, v1.
	st.add_vertex(v4)
	st.add_vertex(v3)
	st.add_vertex(v1)

	# Create normals for the mesh and provide to instance.
	st.generate_normals()
	self.mesh = st.commit();
