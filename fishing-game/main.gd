# Main Menu controller

extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_minigame_manager_game_started(player_data_array: Array[RefCounted]) -> void:
	var game_scene = preload("res://FishGame.tscn");
	var game = game_scene.instantiate();
	
	game.setup(player_data_array);