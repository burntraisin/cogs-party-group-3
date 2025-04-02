extends Rare_fish

var Rare_fish_id = 10
func _process(delta):
	# Update the timer
	timer += delta
	#visible on screen
	if timer == 12:
		Fish_spawn = bool(randi()% 12)
		const speed= 20
		var time= 0.0
		const Switch_interval = 12
		var velocity = Vector2()
		move_fish_position = velocity * delta
		visible= true
		VisibleOnScreenEnabler2D =Fish_spawn
		
