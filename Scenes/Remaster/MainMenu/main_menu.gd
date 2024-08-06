extends Control

@export var game_scene: PackedScene
@export var jam_game_scene: PackedScene

func _on_startgame_button_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_startjam_button_pressed():
	const jam_window_size = Vector2i(384, 216)
	get_window().content_scale_size = jam_window_size
	get_tree().change_scene_to_packed(jam_game_scene)
