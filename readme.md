godot .\2025-02\Making-Stairs\spinning-staircase.tscn --quit-after 300 --write-movie tmp/spinning_v2.png
ffmpeg -framerate 60 -i 'tmp\spinning_v2-%08d.png' -c:v ffv1 tmp\spinning_v2.avi