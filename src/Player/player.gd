extends CharacterBody2D

######################
## MEMBER VARIABLES ##
######################
@export var speed = 250
var screen_size

var current_health = 100
var max_health = 100
var melee_damage = 40

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
		body.take_damage(40, "None")
	
func take_damage(damage):
	current_health -= damage
	
func check_screen_size():
	screen_size = get_viewport_rect().size
