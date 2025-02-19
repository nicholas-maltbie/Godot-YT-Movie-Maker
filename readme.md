godot res://2025-02/Making-Stairs/Staircase-Creation-Scenes/staicase-highlight-steps.tscn --quit-after $(60 * 60) --write-movie tmp/staicase-highlight-steps.png
ffmpeg -framerate 60 -i 'tmp\staicase-highlight-steps%08d.png' -c:v ffv1 tmp\staicase-highlight-steps.avi
