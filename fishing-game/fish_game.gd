#full game controller

extends Node2D
var plr_count;
@onready var stats = get_node("Stats");
@onready var players = get_node("Player");

signal add_score(id, score) 
signal remove_score(id, score)
signal start_fishing(id)


var fish_scene = preload("res://fish.gd");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setup(player_data: Array[RefCounted]) -> void:
	plr_count = player_data.size()

	for i in player_data.size():
		players["Player" + str(i+1)].modulate = player_data[i].color;
		players["Player" + str(i+1)].show;
		stats["Player" + str(i+1)].show;
	
	


func _on_timer_timeout() -> void:
	pass

	# sorry had to comment this out when testing something else
	# var fish = fish_scene.instantiate()
	# fish.position = Vector2(rand_range())


func _on_player_1_done_fishing(id: Variant) -> void:
	pass # Replace with function body.
