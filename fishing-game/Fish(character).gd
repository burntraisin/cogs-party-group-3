extends Sprite

# Fish ID
var fish_id = 12
# Timer variables
var timer = 0.0
var visible_state = true
const Fish_to_appear_timer = 4.0  # 4 seconds

func _ready():
	# Assign a unique ID (could be set dynamically)
	fish_id = randi()
	# Randomize the starting state
	visible_state = bool(randi() % 4)
	# Set initial visibility
	VisibleOnScreenEnabler2D = visible_state

func _process(delta):
	# Update the timer
	timer += delta

	# Toggle visibility every 2 seconds
	if timer >= SWITCH_INTERVAL:
		timer = 0
		visible_state = !visible_state
		visible = visible_state

		# Print the fish ID and its current state for debugging
		print("Fish ID:", fish_id, " Visible:", visible_state)
