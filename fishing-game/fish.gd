extends Node2D

var rarity;
var speed;
var color;

#give the hook a mask of 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup(rarity, speed, color):
	self.rarity = rarity;
	self.speed = speed;
	self.color = color;

	self.FishSprite.modulate = color;