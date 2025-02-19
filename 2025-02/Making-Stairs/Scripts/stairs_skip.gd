@tool
class_name Stairs_Skip
extends Node3D

## Number of steps to include
@export_range(0, 20, 1, "or_greater") var num_step:int = 10:
	get:
		return num_step
	set(value):
		if value <= 0:
			return
		var previous = num_step
		num_step = value
		_build_on_set(previous, num_step)

@export var skip_step:int = 0:
	get:
		return skip_step
	set(value):
		var previous = skip_step
		skip_step = value
		_build_on_set(previous, value)

## Height of each step
@export var step_height:float = 0.2:
	get:
		return step_height
	set(value):
		var previous = step_height
		step_height = value
		_build_on_set(previous, step_height)

## Depth of each step
@export var step_depth:float = 0.35:
	get:
		return step_depth
	set(value):
		var previous = step_depth
		step_depth = value
		_build_on_set(previous, step_depth)

## Width of each step
@export var step_width:float = 1:
	get:
		return step_width
	set(value):
		var previous = step_width
		step_width = value
		_build_on_set(previous, step_width)

## Include square for back of staircase
@export var include_back_face:bool = true:
	get:
		return include_back_face
	set(value):
		var previous = include_back_face
		include_back_face = value
		_build_on_set(previous, include_back_face)

## Texture for stairs
@export var texture:Texture2D:
	get:
		return texture
	set(value):
		var previous = texture
		texture = value
		_build_on_set(previous, value)

@export var top_color:Color = Color.WHITE:
	get:
		return top_color
	set(value):
		var previous = top_color
		top_color = value
		_build_on_set(previous, value)

@export var side_color:Color = Color.WHITE:
	get:
		return side_color
	set(value):
		var previous = side_color
		side_color = value
		_build_on_set(previous, value)

@export var front_color:Color = Color.WHITE:
	get:
		return front_color
	set(value):
		var previous = front_color
		front_color = value
		_build_on_set(previous, value)

@export var back_color:Color = Color.WHITE:
	get:
		return back_color
	set(value):
		var previous = back_color
		back_color = value
		_build_on_set(previous, value)
	
## Debug value to control whether the mesh is updated
## time a value is set.
var _update_on_set=true

func force_update_mesh() -> void:
	# Setup arrays for vertices nad UF
	var vertices_front = PackedVector3Array()
	var vertices_sides = PackedVector3Array()
	var vertices_top = PackedVector3Array()
	var vertices_back = PackedVector3Array()
	var uvs_front = PackedVector2Array()
	var uvs_sides = PackedVector2Array()
	var uvs_top = PackedVector2Array()
	var uvs_back = PackedVector2Array()

	# Build mesh step by step
	var uv_offset = Vector2(step_width, 1)
	var left:float = 0
	var right:float = step_width
	for step in range(skip_step, num_step):
		# Build each step as two sets of squares
		# one on the front, one on the back
		var bottom:float = step * step_height
		var top:float = (step + 1) * step_height
		var front:float = step * step_depth
		var back:float = (step + 1) * step_depth

		# Add front face
		_add_square(vertices_front, Vector3(right, bottom, front), Vector3(right, top, front), \
			Vector3(left, top, front), Vector3(left, bottom, front))
		_add_square_uv(uvs_front, Vector2(right, bottom), Vector2(right, top), \
			Vector2(left, top), Vector2(left, bottom), uv_offset)

		# Add top face
		_add_square(vertices_top, Vector3(right, top, front), Vector3(right, top, back), \
			Vector3(left, top, back), Vector3(left, top, front))
		_add_square_uv(uvs_top, Vector2(right, front), Vector2(right, back), \
			Vector2(left, back), Vector2(left, front), uv_offset)

		# Left side
		_add_square(vertices_sides, Vector3(left, top, front), Vector3(left, top, back), \
			Vector3(left, 0, back), Vector3(left, 0, front))
		_add_square_uv(uvs_sides, Vector2(front, top), Vector2(back, top), \
			Vector2(back, 0), Vector2(front, 0), uv_offset)

		# Right side
		_add_square(vertices_sides, Vector3(right, 0, front), Vector3(right, 0, back), \
			Vector3(right, top, back), Vector3(right, top, front))
		_add_square_uv(uvs_sides, Vector2(front, 0), Vector2(back, 0), \
			Vector2(back, top), Vector2(front, top), uv_offset)

		# If on the last step
		if step == num_step - 1:
			# Add back face if last step
			if include_back_face:
				_add_square(vertices_back, Vector3(left, 0, back), Vector3(left, top, back), \
					Vector3(right, top, back), Vector3(right, 0, back))
				_add_square_uv(uvs_back, Vector2(right, 0), Vector2(right, top), \
					Vector2(left, top), Vector2(left, 0), uv_offset)

	# Build mesh from vertices and UV values
	_build_component(vertices_top, uvs_top, name + "_top", top_color)
	_build_component(vertices_front, uvs_front, name + "_front", front_color)
	_build_component(vertices_sides, uvs_sides, name + "_sides", side_color)
	
	if include_back_face:
		_build_component(vertices_back, uvs_back, name + "_back", back_color)
	else:
		var back = get_node_or_null(name + "_back")
		if back != null:
			remove_child(back)

func _build_component(vertices:PackedVector3Array, uvs:PackedVector2Array, part_name:String, color:Color):
	# Setup mesh instance 3d child
	var mesh_instance:MeshInstance3D = get_node_or_null(part_name)
	if mesh_instance == null:
		mesh_instance = MeshInstance3D.new()
		mesh_instance.name = part_name
		add_child(mesh_instance)
	
	var mat = StandardMaterial3D.new()
	mat.albedo_color = color
	mat.albedo_texture = texture

	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(mat)
	for idx in vertices.size():
		st.set_uv(uvs[idx])
		st.add_vertex(vertices[idx])

	# Add generated mesh to this object
	st.generate_normals()
	st.generate_tangents()
	mesh_instance.mesh = st.commit()

## Upon object entering the scene, build the mesh.
func _ready() -> void:
	var stairs:MeshInstance3D = null
	for child in get_children():
		if child is MeshInstance3D:
			stairs = child
			break

	if stairs == null:
		_build_mesh()

## Check if property has changed and update if configured.
func _build_on_set(previous, new) -> void:
	if is_node_ready() and previous != new and _update_on_set:
		_build_mesh()

## Helper method to add a square to a set of PackedVector3Array as two triangles.
func _add_square(vertices:PackedVector3Array, v1:Vector3, v2:Vector3, v3:Vector3, v4:Vector3) -> void:
	vertices.push_back(v1)
	vertices.push_back(v2)
	vertices.push_back(v3)

	vertices.push_back(v3)
	vertices.push_back(v4)
	vertices.push_back(v1)

## Helper method to add a square to a UV map as two triangles.
func _add_square_uv(uvs:PackedVector2Array, v1:Vector2, v2:Vector2, v3:Vector2, v4:Vector2, uv_offset:Vector2) -> void:
	uvs.push_back(uv_offset - v1)
	uvs.push_back(uv_offset - v2)
	uvs.push_back(uv_offset - v3)

	uvs.push_back(uv_offset - v3)
	uvs.push_back(uv_offset - v4)
	uvs.push_back(uv_offset - v1)

## Create mesh if node is ready, cancel otherwise.
func _build_mesh() -> void:
	force_update_mesh()

## Helper class for managing a line in 3D space.
class Line3D:
	## Starting point of line.
	var v1:Vector3

	## Ending point of line.
	var v2:Vector3

	## Creates a new instance of Line3D with a given start and ending point.
	func _init(start:Vector3, end:Vector3):
		self.v1 = start
		self.v2 = end
