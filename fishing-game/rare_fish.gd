extends Rare_fish

var Rare_fish_id = 10

# Timer variables
var timer = 0.0
const SWITCH_INTERVAL = 12.0  # 12 seconds

# Movement variables
var velocity = Vector2()
const SPEED = 20

func _ready():
	randomize()
	set_random_velocity()
	visible = false  # Initially invisible

func _process(delta):
	# Update the timer
	timer += delta

	# Toggle visibility every 12 seconds
	if timer >= SWITCH_INTERVAL:
		timer = 0
		visible = true
		set_random_velocity()
		print("Rare Fish ID:", Rare_fish_id, " Visible:", visible)

	# Move the fish
	if visible:
		position += velocity * delta
		wrap_around_screen()

func set_random_velocity():
	# Set a random direction and speed
	velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized() * SPEED

func wrap_around_screen():
	var screen_size = get_viewport_rect().size
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0

	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0

		
