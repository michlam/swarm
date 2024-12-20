extends State
class_name EnemyGolemAttack

@export var golem: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var element_status: Node2D
@onready var player = get_parent().get_parent().get_parent().find_child("Player")

@export var golem_attack_scene: PackedScene

func Enter():
	$Timer.start()
	sprite.play("Attack")
	if golem:
		golem.velocity = Vector2.ZERO

func Update(delta):
	# Check for stunned
	if element_status.stunned:
		Transitioned.emit(self, "stunned")
		$Timer.stop()
		

func _on_timer_timeout() -> void:
	create_attack()
	
	# If not in range, stop timer. Transition to walk
	if golem.global_position.distance_to(player.global_position) > 650:
		Transitioned.emit(self, "walk")

func create_attack():
	var golem_attack = golem_attack_scene.instantiate()
	golem.add_child(golem_attack) 
