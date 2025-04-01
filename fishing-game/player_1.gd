# this script controls the fishing game and updating each players stats
extends Control
var current_score = 0;
const plr_id = 1

signal done_fishing(id)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	pass;
