extends CanvasLayer

@onready var fade = $Fade

func fade_and_change_scene(next_scene_path: String):
	var tween = create_tween()
	fade.visible = true

	# Fade in
	tween.tween_property(fade, "modulate:a", 1.0, 0.5)  # 0.5 sec pour fade-in
	await tween.finished

	# Change scene
	get_tree().change_scene_to_file(next_scene_path)

	# Fade out dans la nouvelle scène
	fade.modulate.a = 1.0
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, 0.5)
