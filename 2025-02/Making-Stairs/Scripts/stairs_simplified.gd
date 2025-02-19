@tool
class_name Stairs_Simplified
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

## width of each step
@export var step_width:float = 1:
	get:
		return step_width
	set(value):
		var previous = step_width
		step_width = value
		_build_on_set(previous, step_width)

func force_update_mesh() -> void:
	# Setup arrays for vertices nad UF
	var vertices = PackedVector3Array()

	# Setup material
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(1, 1, 1)
	mat.vertex_color_use_as_albedo = true

	# Build mesh step by step
	var right:float = step_width
	var left:float = 0
	for step in num_step:
		# Build each step as two sets of squares
		# one on the front, one on the back
		var bottom:float = step * step_height
		var top:float = (step + 1) * step_height
		var front:float = step * step_depth
		var back:float = (step + 1) * step_depth

		# Add front face
		_add_square(vertices,
			Vector3(right, bottom, front), Vector3(right, top, front), \
			Vector3(left, top, front), Vector3(left, bottom, front))
		# Add top face
		_add_square(vertices,
			Vector3(right, top, front), Vector3(right, top, back), \
			Vector3(left, top, back), Vector3(left, top, front))
		# Left side
		_add_square(vertices,
			Vector3(left, top, front), Vector3(left, top, back), \
			Vector3(left, 0, back), Vector3(left, 0, front))
		# Right side
		_add_square(vertices,
			Vector3(right, 0, front), Vector3(right, 0, back), \
			Vector3(right, top, back), Vector3(right, top, front))

		# If on the last step
		if step == num_step - 1:
			# Add back face if last step
			_add_square(vertices,
				Vector3(left, 0, back), Vector3(left, top, back), \
				Vector3(right, top, back), Vector3(right, 0, back))

	# Build mesh from vertices and UV values
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(mat)
	for idx in vertices.size():
		st.add_vertex(vertices[idx])

	# Add generated mesh to this object
	st.generate_normals()
	st.generate_tangents()
	var static_body:StaticBody3D = null
	var collision_body:CollisionShape3D = null
	var mesh_instance:MeshInstance3D = null

	for child in get_children():
		if child is MeshInstance3D:
			mesh_instance = child
			break

	# Setup mesh instance 3d child
	if mesh_instance == null:
		mesh_instance = MeshInstance3D.new()
		add_child(mesh_instance)

	mesh_instance.mesh = st.commit()

	for child in get_children():
		if child is StaticBody3D:
			static_body = child
			break

	if static_body == null:
		static_body = StaticBody3D.new()
		add_child(static_body)

	for child in static_body.get_children():
		if child is CollisionShape3D:
			collision_body = child
			break

	if collision_body == null:
		collision_body = CollisionShape3D.new()
		static_body.add_child(collision_body)

	var shape_3d = ConcavePolygonShape3D.new()
	shape_3d.set_faces(vertices)
	collision_body.shape = shape_3d

	if Engine.is_editor_hint():
		if is_inside_tree():
			var root = get_tree().edited_scene_root
			mesh_instance.owner = root
			static_body.owner = root
			collision_body.owner = root
		else:
			mesh_instance.owner = null
			static_body.owner = null
			collision_body.owner = null

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
	if is_node_ready() and previous != new:
		_build_mesh()

## Helper method to add a square to a set of PackedVector3Array as two triangles.
func _add_square(vertices:PackedVector3Array, v1:Vector3, v2:Vector3, v3:Vector3, v4:Vector3) -> void:
	vertices.push_back(v1)
	vertices.push_back(v2)
	vertices.push_back(v3)

	vertices.push_back(v3)
	vertices.push_back(v4)
	vertices.push_back(v1)

## Create mesh if node is ready, cancel otherwise.
func _build_mesh() -> void:
	force_update_mesh()
