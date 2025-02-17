extends MeshInstance3D

# Create a triangle and provide it to this mesh instance.
func _ready():
	# Start creating a new mesh with SurfaceTool
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	# Points for the triangle
	var v1:Vector3 = Vector3(-1, 0, 0)
	var v2:Vector3 = Vector3(0, sqrt(3), 0)
	var v3:Vector3 = Vector3(1, 0, 0)

	# create a triangle by adding v1, v2, v3.
	st.add_vertex(v1)
	st.add_vertex(v2)
	st.add_vertex(v3)

	# Create normals for the mesh
	st.generate_normals()

	# Provide mesh to mesh instance
	self.mesh = st.commit();
