@tool
extends Node3D

@export var color_top = Color.WHITE
@export var color_front = Color.WHITE
@export var color_sides = Color.WHITE
@export var color_back = Color.WHITE
@export var texture:Texture2D = null

var top_mat:StandardMaterial3D
var front_mat:StandardMaterial3D
var sides_mat:StandardMaterial3D
var back_mat:StandardMaterial3D

func _ready():
	top_mat = StandardMaterial3D.new()
	front_mat = StandardMaterial3D.new()
	sides_mat = StandardMaterial3D.new()
	back_mat = StandardMaterial3D.new()
	top_mat.texture = texture
	front_mat.texture = texture
	sides_mat.texture = texture
	back_mat.texture = texture

func _process(delta):
	var top:MeshInstance3D = get_node(name + "_top")
	var front:MeshInstance3D = get_node(name + "_front")
	var sides:MeshInstance3D = get_node(name + "_sides")
	var back:MeshInstance3D = get_node_or_null(name + "_back")
	top_mat.albedo_color = color_top
	front_mat.albedo_color = color_front
	sides_mat.albedo_color = color_sides
	back_mat.albedo_color = color_back
	
	top.set_overr = top_mat
	front.override_material = front_mat
	sides.override_material = sides_mat
	if back != null:
		back.override_material = back_mat
