# this script controls the fishing game and updating each players stats
extends Control

var data = LibraryData.new();
var current_score = 0;
const plr_id = 1;
var rarity = ["CommonBar", "RareBar", "EpicBar", "LegendaryBar"];
var tween

signal done_fishing(id);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = self.create_tween();

	run_fishing();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_tweening():
	pass

func stop_tweening():
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

	# randomizing the bar order
	randomize();
	rarity.shuffle();

	for n in 4:
		bar.move_child(bar.get_node(rarity[n]), n);

	# start the arrow moving
	tween.tween_property(texture, "position", Vector2(294, 145), 0.5);
	tween.tween_property(texture, "position", Vector2(294, 524), 0.5);
	

func _on_game_start_fishing(id) -> void:
	pass
