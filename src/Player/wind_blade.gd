extends Area2D

var speed = 800
var delay_over = false
var damage = 20

@export var sprite: AnimatedSprite2D
@onready var player = get_parent().get_parent().get_parent()

var found_mouse_position = false
var mouse_position
var direction

#func _input(event):
	#if (event is InputEventMouseButton) && !found_mouse_position:
		#mouse_position = event.position
		#direction = find_direction().normalized()
		#found_mouse_position = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = player.position
	sprite.play("Default")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if delay_over && direction:
		position += speed * direction * delta
	else:
		direction = find_direction().normalized()


func _on_timer_timeout() -> void:
	delay_over = true
	visible = true


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage(20, "Wind")


# Find direction of projectile towards mouse
func find_direction() -> Vector2:
	player.check_screen_size()
	var screen_center = player.screen_size / 2
	
	mouse_position = get_viewport().get_mouse_position()
	return mouse_position - screen_center
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
