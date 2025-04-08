#full game controller

extends Node2D
var plr_count = 1;
var timer_status = 0;
var scores = {
	"Player 1" = 0,
	"Player 2" = 0,
	"Player 3" = 0,
	"Player 4" = 0,
}

var fish_scene = preload("res://FishGame.tscn");

@onready var stats = get_node("Stats");
@onready var players = get_node("Player");
@onready var timer = stats.get_node("Timer").get_node("Name");
@onready var highest = stats.get_node("CurrentLeader").get_node("Name");

signal add_score(id, score);
signal remove_score(id, score);

signal start_fishing(id);
signal stop_fishing(id);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var highest_name = "Player 1"
	for key in scores:
		if scores[key] > scores[highest_name]:
			highest_name = key;
	highest.text = "[center] Current Leader: " + highest_name + " [/center]";

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

func controller() -> void:
	for n in range(5, -0, -1):	
		timer.text = "[center] " + str(n) + "... [/center]";
		await get_tree().create_timer(1).timeout;

	timer.text = "[center] Get Ready... [/center]";
	await get_tree().create_timer(1).timeout;
	timer.text = "[center] GO!!! [/center]";
	await get_tree().create_timer(1).timeout;
	stats.get_node("TimeRemaining").start();
	timer_status = 1;

	for n in range(1, plr_count + 1):
		start_fishing.emit(n);

	await stats.get_node("TimeRemaining").timeout;
	print("Time's up!");

	for n in range(1, plr_count + 1):
		stop_fishing.emit(n);

func _on_time_remaining_timeout():
	timer_status = 0;
	timer.text = "[center] Game Over! [/center]";
	await get_tree().create_timer(3).timeout;
	timer.text = "[center] And the winner is... [/center]";
	await get_tree().create_timer(3).timeout;


func _on_player_1_send_score_to_main(score) -> void:
	scores["Player 1"] = score;
