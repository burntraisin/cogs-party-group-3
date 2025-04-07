# this script controls the fishing game and updating each players stats
extends Control

var data = LibraryData.new();
var current_score = 0;
const plr_id = 1;

var rarity = ["Common", "Rare", "Epic", "Legendary"];

var currently_fishing = false;
var is_run_fishing_running = false;
signal stop_fishing_button();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currently_fishing:
		if !is_run_fishing_running:
			print("Changed");
			run_fishing();

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("backspace_pressed"):
		stop_fishing_button.emit();

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
	is_run_fishing_running = true;
	var texture = self.get_node("ArrowStart");
	var bar = self.get_node("ProgressBar").get_node("RarityHolder");

	#randomizing the rarity
	randomize();
	rarity.shuffle();
	texture.position = Vector2(294, 523);

	for n in 4:
		bar.move_child(bar.get_node(rarity[n]), n);
	#tweening the progress bar
	var tween = get_tree().create_tween();
	tween.set_loops();
	tween.tween_property(texture, "position", Vector2(294, 144), 0.25);
	tween.tween_property(texture, "position", Vector2(294, 523), 0.25);
	await stop_fishing_button;
	tween.kill();

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
