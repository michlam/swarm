extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle the enemy goblin moving towards the player
	var to_player_direction = $Player.get_position() - $Enemy_Goblin.get_position()
	$Enemy_Goblin.velocity = to_player_direction.normalized() * 30 * delta 
	var collision = $Enemy_Goblin.move_and_collide($Enemy_Goblin.velocity)
