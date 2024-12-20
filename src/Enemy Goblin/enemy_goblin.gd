extends CharacterBody2D

######################
## MEMBER VARIABLES ##
######################
@export var damage_number_scene: PackedScene
@export var speed = 250
@onready var experience = get_parent().find_child("Experience")


var screen_size
var is_attacking = false
var max_health
var current_health
var type = "Goblin"

func _ready() -> void:
	# Spawn enemy
	add_to_group("enemies")
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

func take_damage(damage: int, type: String):
	# Create a damage number scene
	var damage_number = damage_number_scene.instantiate()
	add_child(damage_number) 
	
	# Apply the elemental reaction
	var colour = $ElementStatus.get_element_colour(type)
	var elemental_damage_multiplier = $ElementStatus.apply_element(type)
	damage = damage * elemental_damage_multiplier
	
	# Set the damage numbers
	damage_number.set_values_and_animate(damage, Vector2(0, -50), 60, colour)
	current_health -= damage
	
	if current_health <= 0:
		experience.create_xp_orb(max_health, position)
		death_handler()
	
func death_handler():
	hide()
	$Hurtbox.set_deferred("disabled", true)
	queue_free()
