#full game controller

extends Node2D
var plr_count;
var timer_status = 0;

var fish_scene = preload("res://FishGame.tscn");

@onready var stats = get_node("Stats");
@onready var players = get_node("Player");
@onready var timer = stats.get_node("Timer").get_node("Name");

signal add_score(id, score);
signal remove_score(id, score);
signal start_fishing(id);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	controller();
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_status == 1:
		var time_left = stats.get_node("TimeRemaining").time_left;
		var minute = floor(time_left / 60);
		var second = int(time_left) % 60;
		var time = "%02d:%02d" % [minute, second];
		timer.text = "[center] Time Remaining: " + time + " [/center]";


func setup(player_data: Array[RefCounted]) -> void:
	plr_count = player_data.size()

	for i in player_data.size():
		players["Player" + str(i+1)].modulate = player_data[i].color;
		players["Player" + str(i+1)].show;
		stats["Player" + str(i+1)].show;


func _on_player_1_done_fishing(id: Variant) -> void:
	pass # Replace with function body.

func controller() -> void:
	for n in range(10, -0, -1):	
		print(n);
		timer.text = "[center] " + str(n) + "... [/center]";
		await get_tree().create_timer(1).timeout;

	timer.text = "[center] Get Ready... [/center]";
	await get_tree().create_timer(1).timeout;
	timer.text = "[center] GO!!! [/center]";
	await get_tree().create_timer(1).timeout;
	stats.get_node("TimeRemaining").start();
	timer_status = 1;

	pass

func _on_time_remaining_timeout():
	timer_status = 0;
	timer.text = "[center] Game Over! [/center]";
	await get_tree().create_timer(3).timeout;
	timer.text = "[center] And the winner is... [/center]";
	await get_tree().create_timer(3).timeout;