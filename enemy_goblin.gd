extends CharacterBody2D

######################
## MEMBER VARIABLES ##
######################
@export var damage_number_scene: PackedScene
@export var speed = 250

var screen_size
var is_attacking = false
var max_health = 100
var current_health = 100

func _ready() -> void:
	# Spawn enemy
	screen_size = get_viewport_rect().size
	position = 0.5 * screen_size + Vector2(100, 0)

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("Walk")
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

func take_damage(damage):
	current_health -= damage
	var damage_number = damage_number_scene.instantiate()
	add_child(damage_number) 
	damage_number.set_values_and_animate(damage, Vector2(0, -30), 30)
	
func death_handler():
	hide()
	$Hurtbox.set_deferred("disabled", true)
	queue_free()
	
