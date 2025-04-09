extends Node2D

var rarity;
var speed;
var color;

var is_fishable = true;
var fish_lifespan = 10;
var fish_age = 0;

#give the hook a mask of 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fish_age += delta;

	if fish_age > fish_lifespan:
		is_fishable = false;
		var tween = get_tree().create_tween();
		tween.tween_property(self.get_node("FishSprite"), "modulate:a", 0, 2.5);
		await tween.finished;
		queue_free();

func setup(rarity, speed, color):
	self.rarity = rarity;
	self.speed = speed;
	self.color = color;

	self.get_node("FishSprite").modulate = color;

func get_fishable() -> bool:
	return is_fishable;