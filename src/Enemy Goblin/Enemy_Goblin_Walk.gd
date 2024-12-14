extends State
class_name EnemyGoblinWalk

@export var goblin: CharacterBody2D
@export var sprite: AnimatedSprite2D
@onready var player = get_parent().get_parent().get_parent().find_child("Player")

func Enter():
	sprite.play("Walk")
	if goblin:
		goblin.velocity = Vector2.ZERO

func Update(delta):
	# Handle the enemy goblin moving towards the player
	var to_player_direction = player.position - goblin.position
	goblin.velocity = to_player_direction.normalized() * 30 * delta 
	goblin.move_and_collide(goblin.velocity)
		
func Physics_Update(delta):
	pass
	
