godot .\2025-02\Making-Stairs\spinning-staircase.tscn --quit-after 300 --write-movie tmp/spinning.png
ffmpeg -framerate 60 -i 'tmp\spinning%08d.png' -c:v ffv1 tmp\many.avi