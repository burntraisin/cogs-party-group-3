# this script controls the fishing game and updating each players stats
extends Control

var data = LibraryData.new();
var current_score = 0;
const plr_id = 1;
var rarity_sizes = {
	"CommonBar" = float(95.2),
	"RareBar" = float(71.4),
	"EpicBar" = float(47.6),
	"LegendaryBar" = float(23.8),
}

signal done_fishing(id);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_game_start_fishing(1);
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
	self.Score.text = "[center] Score: " + str(current_score) + " [/center]"


func _on_game_remove_score(id:Variant, score:Variant) -> void:
	if (id != plr_id):
		return
	
	var new_score = current_score - score;
	current_score = new_score;
	self.Score.text = "[center] Score: " + str(current_score) + " [/center]"

func _on_game_start_fishing(id) -> void:
	# randomizing the bar order
	if (id != plr_id):
		return
		
	var bar = self.get_node("InnerProgressBar");
	var rarity_copy = rarity_sizes.duplicate();
	var position = 0;
	
	for n in 4:
		var key = rarity_copy.keys().pick_random();
		bar.get_node(key).position = Vector2(0, position);
		position += rarity_copy[key];
		print("Current key: " + key + ". Current position: " + str(position));
		rarity_copy.erase(key);

	# start the arrow moving
