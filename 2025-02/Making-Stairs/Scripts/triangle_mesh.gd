@tool
extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_color(Color.WHITE)

	st.set_uv(Vector2(-0.5, 0))
	st.add_vertex(Vector3(-0.5, 0, 0))

	st.set_uv(Vector2(0, 1))
	st.add_vertex(Vector3(0, 1, 0))

	st.set_uv(Vector2(0.5, 0))
	st.add_vertex(Vector3(0.5, 0, 0))
	
	self.mesh = st.commit();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
