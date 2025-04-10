extends Node2D
var data = LibraryData.new();

var rarity;
var speed;
var color;

var is_fishable = true;
var fish_lifespan = 10;
var fish_age = 0;

@onready var body = self.get_node("CharacterBody2D");
@onready var sprite = body.get_node("FishSprite");

#give the hook a mask of 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fish_age += delta;

	if fish_age >= fish_lifespan:
		is_fishable = false;
		var tween = get_tree().create_tween();
		tween.tween_property(self, "modulate:a", 0, 2.5);
		await tween.finished;
		queue_free();

func setup(rarity, speed, color):
	self.rarity = rarity;
	self.color = color;
	self.modulate = color;
	body.velocity = speed;

func _physics_process(delta: float) -> void:
	if is_fishable:
		var random_angle: float = randf_range(0, TAU);
		var direction = Vector2.from_angle(random_angle);
		var collision = body.move_and_collide(direction);

		if collision:
			if collision.get_collider().is_in_group("pond_edge"):
				print("Collided")
				var normal = collision.get_normal()
				body.velocity = body.velocity.bounce(-normal) * 0.8;

func get_fishable() -> bool:
	return is_fishable;