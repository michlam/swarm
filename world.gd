extends Node2D

@onready var health_bar: TextureProgressBar = $HealthBar
const Enemy_Goblin = preload("res://enemy_goblin.tscn")

var health_bar_offset = Vector2(-33, -55)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = $Player.max_health
	health_bar.value = $Player.current_health
	health_bar.scale = Vector2(2, 2)
	
	# Create an enemy mob
	var new_enemy_goblin = Enemy_Goblin.instantiate()
	add_child(new_enemy_goblin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_healthbar_helper()
	process_movement_helper(delta)
	process_animation_helper()


func process_healthbar_helper():
		# Handle health bar always above player
	health_bar.position = $Player.position + health_bar_offset
	
	
func process_movement_helper(delta):
	# Handle the enemy goblin moving towards the player
	var to_player_direction = $Player.get_position() - $Enemy_Goblin.get_position()
	$Enemy_Goblin.velocity = to_player_direction.normalized() * 30 * delta 
	var collision = $Enemy_Goblin.move_and_collide($Enemy_Goblin.velocity)
	
func process_animation_helper():
	health_bar.value = $Player.current_health
