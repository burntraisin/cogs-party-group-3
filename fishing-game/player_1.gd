# this script controls the fishing game and updating each players stats
extends Control

var data = LibraryData.new();
var current_score = 0;
const plr_id = 1;

var rarity = ["Common", "Rare", "Epic", "Legendary"];
var input = "backspace_pressed"

var currently_fishing = false;
var is_run_fishing_running = false;

signal stop_fishing_button();
signal send_score_to_main(score);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currently_fishing:
		if !is_run_fishing_running:
			run_fishing();

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed(input):
		stop_fishing_button.emit();

func _on_game_add_score(id, score) -> void:
	if (id != plr_id):
		return
	
	var new_score = current_score + score;
	current_score = new_score;
	self.get_node("Score").text = "     Coins: " + str(current_score)

	send_score_to_main.emit(current_score);

func _on_game_remove_score(id:Variant, score:Variant) -> void:
	if (id != plr_id):
		return
	
	var new_score = current_score - score;
	current_score = new_score;
	self.get_node("Score").text = "     Coins: " + str(current_score)

	send_score_to_main.emit(current_score);

func run_fishing() -> void:
	is_run_fishing_running = true;
	var texture = self.get_node("ArrowStart");
	var texture_position = self.get_node("ArrowPosition");
	var bar = self.get_node("ProgressBar").get_node("RarityHolder");

	randomize();
	rarity.shuffle();
	texture.position = Vector2(294, 522);

	for n in 4:
		bar.move_child(bar.get_node(rarity[n]), n);

	var tween = get_tree().create_tween();
	tween.set_loops();
	tween.tween_property(texture, "position", Vector2(294, 143), 0.35);
	tween.parallel().tween_property(texture_position, "position", Vector2(199,103), 0.35);
	tween.tween_property(texture, "position", Vector2(294, 522), 0.35);
	tween.parallel().tween_property(texture_position, "position", Vector2(199,482), 0.35);
	await stop_fishing_button;
	tween.kill();

	var selected_rarity;
	for n in self.get_node("ProgressBar").get_node("RarityHolder").get_children():
		if texture_position.global_position.y >= n.global_position.y:
			if texture_position.global_position.y < (n.global_position.y + n.size.y):
				selected_rarity = n.name;
	if selected_rarity == null:
		selected_rarity = self.get_node("ProgressBar").get_node("RarityHolder").get_children()[0].name;
		print(texture_position.global_position.y);
		print("Could not detect a rarity");

	var selected_fish = data.fish_rarity[selected_rarity].pick_random();
	_on_game_add_score(plr_id, data.fish_score[selected_rarity]);

	await get_tree().create_timer(3).timeout;
	is_run_fishing_running = false;


func _on_game_start_fishing(id) -> void:
	if (id != plr_id):
		return;
		
	currently_fishing = true;

func _on_game_stop_fishing(id:Variant) -> void:
	if (id != plr_id):
		return;
		
	currently_fishing = false;
	self.get_node("ArrowStart").queue_free();
	self.get_node("ArrowPosition").queue_free();
