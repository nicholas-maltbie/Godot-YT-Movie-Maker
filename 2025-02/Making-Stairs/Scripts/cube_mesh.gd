@tool
extends MeshInstance3D

@export var texture:Texture2D

# Points for the cube
var v1:Vector3 = Vector3(0, 0, 0)
var v2:Vector3 = Vector3(0, 0, 1)
var v3:Vector3 = Vector3(0, 1, 0)
var v4:Vector3 = Vector3(0, 1, 1)
var v5:Vector3 = Vector3(1, 0, 0)
var v6:Vector3 = Vector3(1, 0, 1)
var v7:Vector3 = Vector3(1, 1, 0)
var v8:Vector3 = Vector3(1, 1, 1)

func _label_point(point:Vector3, name:String) -> void:
	var label = Label3D.new()
	label.position = point
	label.text = name
	label.name = "label_" + name
	add_child(label)

func _add_face(st:SurfaceTool, _v1:Vector3, _v2:Vector3, _v3:Vector3, _v4:Vector3) -> void:
	# first triangle
	st.set_uv(Vector2(0, 0))
	st.add_vertex(_v1)
	st.set_uv(Vector2(0, 1))
	st.add_vertex(_v3)
	st.set_uv(Vector2(1, 0))
	st.add_vertex(_v2)

	# second triangle
	st.set_uv(Vector2(1, 0))
	st.add_vertex(_v2)
	st.set_uv(Vector2(0, 1))
	st.add_vertex(_v3)
	st.set_uv(Vector2(1, 1))
	st.add_vertex(_v4)

func _ready() -> void:
	_label_point(v1 + Vector3.FORWARD * 0.1, "v1")
	_label_point(v2 + Vector3.BACK * 0.1 , "v2")
	_label_point(v3 + Vector3.FORWARD * 0.1, "v3")
	_label_point(v4 + Vector3.BACK * 0.1, "v4")
	_label_point(v5 + Vector3.FORWARD * 0.1, "v5")
	_label_point(v6 + Vector3.BACK * 0.1, "v6")
	_label_point(v7 + Vector3.FORWARD * 0.1, "v7")
	_label_point(v8 + Vector3.BACK * 0.1, "v8")

	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	_add_face(st, v1, v2, v3, v4) # front face
	_add_face(st, v5, v7, v6, v8) # back face
	_add_face(st, v1, v3, v5, v7) # left face
	_add_face(st, v2, v6, v4, v8) # right face
	_add_face(st, v3, v4, v7, v8) # top face
	_add_face(st, v1, v5, v2, v6) # bottom face
	
	# Setup material
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.WHITE
	mat.albedo_texture = texture
	mat.vertex_color_use_as_albedo = true
	st.set_material(mat)
	st.generate_normals()

	self.mesh = st.commit();

