@tool
extends Stairs

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw3D.scoped_config().set_thickness(0.01).set_no_depth_test(false)
	var front_bottom_left = transform.origin
	var front_top_left = to_global(Vector3(0, step_height, 0))
	var back_top_left = to_global(Vector3(0, step_height, step_depth))
	DebugDraw3D.draw_sphere(front_top_left, 0.01, Color.GREEN)
	DebugDraw3D.draw_arrow(front_top_left, front_bottom_left, Color.BLUE, 0.1)
	DebugDraw3D.draw_arrow(front_top_left, back_top_left, Color.RED, 0.1)
