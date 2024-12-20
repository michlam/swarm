extends State
class_name EnemyGolemWalk

@export var golem: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var element_status: Node2D
@onready var player = get_parent().get_parent().get_parent().find_child("Player")

func Enter():
	$Timer.start()
	sprite.play("Walk")
	if golem:
		golem.velocity = Vector2.ZERO

func Update(delta):
	# Handle the enemy golem moving towards the player
	var to_player_direction = player.position - golem.position
	golem.velocity = to_player_direction.normalized() * 30 * delta 
	golem.move_and_collide(golem.velocity)
	
	# Check for stunned
	if element_status.stunned:
		Transitioned.emit(self, "stunned")
		
func Physics_Update(delta):
	pass
	

func _on_timer_timeout() -> void:
	if golem.global_position.distance_to(player.global_position) < 400:
		$Timer.stop()
		Transitioned.emit(self, "attack")
