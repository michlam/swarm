extends Area2D

var speed = 1200
var base_damage = 30

@export var sprite: AnimatedSprite2D
@onready var player = get_parent().get_parent().get_parent()
@onready var player_stats = player.find_child("Stats")

var found_mouse_position = false
var mouse_position
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = player.position
	sprite.play("Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += speed * direction * delta
	else:
		direction = find_direction().normalized()
		rotation = direction.angle()


# Find direction of projectile towards mouse
func find_direction() -> Vector2:
	player.check_screen_size()
	var screen_center = player.screen_size / 2
	mouse_position = get_viewport().get_mouse_position()
	return mouse_position - screen_center

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage(player_stats.get_ability_damage(base_damage, "Ice"), "Ice")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
