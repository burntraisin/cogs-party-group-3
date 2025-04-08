# Main Menu controller

extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var buttons = self.get_node("MenuNode").get_node("MainMenuContainer").get_node("HBoxContainer").get_node("RightSide").get_node("MarginContainer").get_node("Buttons");

	buttons.get_node("FishLibrary").pressed.connect(open_fishing_library);
	self.get_node("FishLibraryNode").get_node("Close").pressed.connect(close_fishing_library);

	buttons.get_node("Rules").pressed.connect(open_rules);
	self.get_node("RulesNode").get_node("Close").pressed.connect(close_rules);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_minigame_manager_game_started(player_data_array: Array[RefCounted]) -> void:
	var game_scene = preload("res://FishGame.tscn");
	var game = game_scene.instantiate();
	
	game.setup(player_data_array);

func open_fishing_library() -> void:
	self.get_node("FishLibraryNode").visible = true;

func close_fishing_library() -> void:
	self.get_node("FishLibraryNode").visible = false;

func open_rules() -> void:
	self.get_node("RulesNode").visible = true;

func close_rules() -> void:
	self.get_node("RulesNode").visible = false;