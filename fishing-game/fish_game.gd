#full game controller

extends Node2D
var plr_count;
@onready var stats = get_node("Stats");
@onready var players = get_node("Player");

signal update_score(score) 

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
	
	