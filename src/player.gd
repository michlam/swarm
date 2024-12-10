extends CharacterBody2D

######################
## MEMBER VARIABLES ##
######################
@export var speed = 250
var screen_size
var is_attacking = false

var current_health = 100
var max_health = 100
var melee_damage = 40

func _ready() -> void:
	# Spawn player in the center of the screen
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	process_zooming()
	
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if !is_attacking: # If already attacking, don't process any other movements
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1

	if Input.is_action_pressed("click_attack"):
		is_attacking = true
		velocity = Vector2.ZERO

	if is_attacking:
		$AnimatedSprite2D.play("Attack_Hori_1")
		$AnimationPlayer.play("Attack_Hori_1")
	elif velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")
		
	position += velocity * delta
	
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
		$Camera2D.zoom *= 0.95
	
func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false

func _on_melee_hitbox_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage(40)
	
func take_damage(damage):
	current_health -= damage
