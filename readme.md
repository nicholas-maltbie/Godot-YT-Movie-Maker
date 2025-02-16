godot .\2025-02\Making-Stairs\highlight-step-width-and-height.tscn --quit-after 600 --write-movie tmp/highlight.png^C
ffmpeg -framerate 60 -i 'highlight%08d.png' -c:v ffv1 highlight.avi