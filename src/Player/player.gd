extends CharacterBody2D

######################
## MEMBER VARIABLES ##
######################
var screen_size

func _ready() -> void:
	# Spawn player in the center of the screen
	check_screen_size()

func _process(delta: float) -> void:
	process_zooming()

	# Change player facing direction
	if velocity.x != 0:
		if velocity.x < 0:
			scale.x = -0.65
		else:
			scale.x = 0.65

func process_zooming():
	# Check for scroll wheel for camera:
	if Input.is_action_just_released("scroll_in"):
		$Camera2D.zoom *= 1.05
	elif Input.is_action_just_released("scroll_out"):
		if $Camera2D.zoom.x > 0.96:
			$Camera2D.zoom *= 0.95

func _on_melee_hitbox_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage($Stats.get_melee_damage(), "None")
	
func take_damage(damage):
	$Stats.take_damage(damage)
	
func check_screen_size():
	screen_size = get_viewport_rect().size

func _on_exp_detect_radius_area_entered(area: Area2D) -> void:
	# Tell orb to come to player
	if area.is_in_group("exp"):
		area.go_to_player()


func _on_exp_collect_radius_area_entered(area: Area2D) -> void:
	if area.is_in_group("exp"):
		$Stats.gain_exp(area.exp_amount)
		area.queue_free()
