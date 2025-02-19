@tool
extends MeshInstance3D

@export var texture:Texture2D

# Points for the square
var v1:Vector3 = Vector3(-1, -1, 0)
var v2:Vector3 = Vector3(-1, 1, 0)
var v3:Vector3 = Vector3(1, 1, 0)
var v4:Vector3 = Vector3(1, -1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var label_v1 = Label3D.new()
	label_v1.position = v1 + Vector3.BACK * 0.2
	label_v1.text = "v1"
	add_child(label_v1)
	var label_v2 = Label3D.new()
	label_v2.position = v2 + Vector3.BACK * 0.2
	label_v2.text = "v2"
	add_child(label_v2)
	var label_v3 = Label3D.new()
	label_v3.position = v3 + Vector3.BACK * 0.2
	label_v3.text = "v3"
	add_child(label_v3)
	var label_v4 = Label3D.new()
	label_v4.position = v4 + Vector3.BACK * 0.2
	label_v4.text = "v4"
	add_child(label_v4)
	
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	st.set_uv(Vector2(v1.x, v1.y))
	st.add_vertex(v1)
	st.set_uv(Vector2(v2.x, v2.y))
	st.add_vertex(v2)
	st.set_uv(Vector2(v3.x, v3.y))
	st.add_vertex(v3)

	st.set_uv(Vector2(v3.x, v3.y))
	st.add_vertex(v3)
	st.set_uv(Vector2(v4.x, v4.y))
	st.add_vertex(v4)
	st.set_uv(Vector2(v1.x, v1.y))
	st.add_vertex(v1)
	
	# Setup material
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.WHITE
	mat.albedo_texture = texture
	st.set_material(mat)
	st.generate_normals()

	self.mesh = st.commit();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw3D.scoped_config().set_no_depth_test(true)
	DebugDraw3D.draw_line(to_global(v1), to_global(v2))
	DebugDraw3D.draw_line(to_global(v2), to_global(v3))
	DebugDraw3D.draw_line(to_global(v3), to_global(v1))
	
	DebugDraw3D.draw_line(to_global(v3), to_global(v4))
	DebugDraw3D.draw_line(to_global(v4), to_global(v1))
	DebugDraw3D.draw_line(to_global(v1), to_global(v3))
