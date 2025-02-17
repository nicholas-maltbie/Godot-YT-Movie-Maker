@tool
extends MeshInstance3D

@export var texture:Texture2D

# Points for the triangle
var v1:Vector3 = Vector3(-1, 0, 0)
var v2:Vector3 = Vector3(0, sqrt(3), 0)
var v3:Vector3 = Vector3(1, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	st.set_color(Color.WHITE)
	st.set_uv(Vector2(v1.x, v1.y))
	st.set_normal(Vector3.ZERO)
	st.add_vertex(v1)

	st.set_color(Color.WHITE)
	st.set_uv(Vector2(v2.x, v2.y))
	st.set_normal(Vector3.ZERO)
	st.add_vertex(v2)

	st.set_color(Color.WHITE)
	st.set_uv(Vector2(v3.x, v3.y))
	st.set_normal(Vector3.ZERO)
	st.add_vertex(v3)
	
	# Setup material
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.WHITE
	mat.albedo_texture = texture
	mat.vertex_color_use_as_albedo = true
	st.set_material(mat)
	st.generate_normals()

	self.mesh = st.commit();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw3D.draw_line(to_global(v1), to_global(v2))
	DebugDraw3D.draw_line(to_global(v2), to_global(v3))
	DebugDraw3D.draw_line(to_global(v3), to_global(v1))
