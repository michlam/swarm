extends Node2D

@onready var health_bar: TextureProgressBar = $HealthBar
@export var enemy_goblin_scene: PackedScene

var health_bar_offset = Vector2(-33, -55)
var enemies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = $Player.max_health
	health_bar.value = $Player.current_health
	health_bar.scale = Vector2(2, 2)
	enemies = get_tree().get_nodes_in_group("enemies")
	
	$MobTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_healthbar_helper()
	process_movement_helper(delta)
	process_animation_helper()


func process_healthbar_helper():
		# Handle health bar always above player
	health_bar.position = $Player.position + health_bar_offset
	
	
func process_movement_helper(delta):
	for enemy in enemies:
		# Check for enemy deaths
		if enemy.current_health <= 0:
			enemy.death_handler()
			remove_child(enemy)
			enemies = get_tree().get_nodes_in_group("enemies")
		else:
			# Handle the enemy goblin moving towards the player
			var to_player_direction = $Player.get_position() - enemy.get_position()
			enemy.velocity = to_player_direction.normalized() * 30 * delta 
			var collision = enemy.move_and_collide(enemy.velocity)
	
func process_animation_helper():
	health_bar.value = $Player.current_health


func _on_mob_timer_timeout() -> void:
	var enemy_goblin = enemy_goblin_scene.instantiate()
	add_child(enemy_goblin) 
	enemy_goblin.add_to_group("enemies")
	enemies = get_tree().get_nodes_in_group("enemies")
	
	print(enemies)
