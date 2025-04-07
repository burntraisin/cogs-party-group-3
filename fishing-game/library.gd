class_name LibraryData extends Node

var fish_score = {
	"Common" = 15,
	"Rare" = 25,
	"Epic" = 50,
	"Legendary" = 100,
};

var fish_rarity = {
	"Common" = ["Coho Salmon", "Moray Eel", "Striped Bass", "Tuna"],
	"Rare" = ["Northern Stargazer", "African Glass Catfish",],
	"Epic" = ["Oarfish", "Wobbegong"],
	"Legendary" = ["Great White Shark", "Coelacanth"],
};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass