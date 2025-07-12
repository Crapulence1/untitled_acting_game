extends Node2D

func _on_play_pressed() -> void:
	var new_scene = load("res://Scenes/battle_area.tscn")
	get_tree().change_scene_to_packed(new_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
