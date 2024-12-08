extends Node2D

@onready var health_bar: TextureProgressBar = $HealthBar

var current_health = 100
var max_health = 100
var health_bar_offset = Vector2(-33, -55)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = max_health
	health_bar.value = current_health
	health_bar.scale = Vector2(2, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_healthbar_helper()
	process_movement_helper(delta)


func process_healthbar_helper():
		# Handle health bar always above player
	health_bar.position = $Player.position + health_bar_offset
	
	
func process_movement_helper(delta):
	# Handle the enemy goblin moving towards the player
	var to_player_direction = $Player.get_position() - $Enemy_Goblin.get_position()
	$Enemy_Goblin.velocity = to_player_direction.normalized() * 30 * delta 
	var collision = $Enemy_Goblin.move_and_collide($Enemy_Goblin.velocity)
	
	if collision:
		health_bar.value -= 1
		print(health_bar.value)

	if health_bar.value == 0:
		print("Lol you dead n00b")
	
