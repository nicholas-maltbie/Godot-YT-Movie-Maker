godot res://2025-02/Making-Stairs/Mesh-Creation-Scenes/lighting_triangle.tscn --quit-after 240 --write-movie tmp/lighting_triangle_normals.png
ffmpeg -framerate 60 -i 'tmp\lighting_triangle_normals%08d.png' -c:v ffv1 tmp\lighting_triangle_normals.avi