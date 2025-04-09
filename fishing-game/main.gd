# Main Menu controller
extends Node2D
var data_array;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var buttons = self.get_node("MenuNode").get_node("MainMenuContainer").get_node("HBoxContainer").get_node("RightSide").get_node("MarginContainer").get_node("Buttons");

	buttons.get_node("FishLibrary").pressed.connect(open_fishing_library);
	self.get_node("FishLibraryNode").get_node("Close").pressed.connect(close_fishing_library);

	buttons.get_node("Rules").pressed.connect(open_rules);
	self.get_node("RulesNode").get_node("Close").pressed.connect(close_rules);

	buttons.get_node("StartGame").pressed.connect(start_the_game);

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("back_button"):
		if self.get_node("RulesNode").visible:
			close_rules();
		elif self.get_node("FishLibraryNode").visible:
			close_fishing_library();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_minigame_manager_game_started(player_data_array: Array[RefCounted]) -> void:	
	data_array = player_data_array;

func start_the_game() -> void:
	var game_scene = preload("res://FishGame.tscn");
	var game = game_scene.instantiate();

	if data_array:
		game.setup(data_array);

	self.get_node("MenuNode").get_node("MainMenuContainer").get_node("HBoxContainer").get_node("RightSide").get_node("MarginContainer").get_node("Buttons").get_node("StartGame").text = "Loading...";
	await get_tree().create_timer(3).timeout;
	
	self.add_child(game);
	game.visible = true;
	self.get_node("MenuNode").visible = false;
	self.get_node("FishLibraryNode").visible = false;
	self.get_node("RulesNode").visible = false;
	self.get_node("MenuNode").get_node("MainMenuContainer").get_node("HBoxContainer").get_node("RightSide").get_node("MarginContainer").get_node("Buttons").get_node("StartGame").text = "Start Game";

	await game.controller();
	self.get_node("MenuNode").visible = true;
	game.queue_free();

func open_fishing_library() -> void:
	self.get_node("FishLibraryNode").visible = true;

func close_fishing_library() -> void:
	self.get_node("FishLibraryNode").visible = false;

func open_rules() -> void:
	self.get_node("RulesNode").visible = true;

func close_rules() -> void:
	self.get_node("RulesNode").visible = false;