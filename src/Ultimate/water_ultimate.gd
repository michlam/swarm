extends Area2D

var speed = 600
var base_damage = 100

@export var sprite: AnimatedSprite2D
@onready var player = get_parent().get_parent().get_parent()
@onready var ultimate_node = get_parent()
@onready var player_stats = player.find_child("Stats")

var found_mouse_position = false
var mouse_position
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = player.position
	player_stats.speed = speed
	player_stats.is_invincible = true
	player.visible = false
	
	sprite.play("Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Just need to find the rotation, following player velocity
	direction = find_direction().normalized()
	rotation = direction.angle()
	
	player.position += speed * direction * delta
	position = player.position

# Find direction of projectile towards mouse
func find_direction() -> Vector2:
	player.check_screen_size()
	var screen_center = player.screen_size / 2
	mouse_position = get_viewport().get_mouse_position()
	return mouse_position - screen_center

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage(player_stats.get_ability_damage(base_damage, "Water"), "Water")

func _on_timer_timeout() -> void:
	player.visible = true
	player_stats.speed = player_stats.base_speed
	player_stats.is_invincible = false
	ultimate_node.ultimate_complete = true
	queue_free()
