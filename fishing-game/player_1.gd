# this script controls the fishing game and updating each players stats
extends Control

var data = LibraryData.new();
var current_score = 0;
const plr_id = 1;
var rarity = ["CommonBar", "RareBar", "EpicBar", "LegendaryBar"];

# 523, 144

signal done_fishing(id);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	run_fishing();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_add_score(id, score) -> void:
	if (id != plr_id):
		return
	
	var new_score = current_score + score;
	current_score = new_score;
	self.get_node("Score").text = "[center] Score: " + str(current_score) + " [/center]"

func _on_game_remove_score(id:Variant, score:Variant) -> void:
	if (id != plr_id):
		return
	
	var new_score = current_score - score;
	current_score = new_score;
	self.get_node("Score").text = "[center] Score: " + str(current_score) + " [/center]"

func run_fishing() -> void:
	var texture = self.get_node("ArrowStart");
	var bar = self.get_node("ProgressBar").get_node("RarityHolder");

	randomize();
	rarity.shuffle();

	for n in 4:
		bar.move_child(bar.get_node(rarity[n]), n);

	

func _on_game_start_fishing(id) -> void:
	pass