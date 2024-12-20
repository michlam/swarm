extends State
class_name EnemyMageAttack

@export var mage: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var element_status: Node2D
@onready var player = get_parent().get_parent().get_parent().find_child("Player")

@export var mage_attack_scene: PackedScene

func Enter():
	$Timer.start()
	sprite.play("Default")
	if mage:
		mage.velocity = Vector2.ZERO

func Update(delta):
	# Check for stunned
	if element_status.stunned:
		Transitioned.emit(self, "stunned")
		$Timer.stop()
		

func _on_timer_timeout() -> void:
	create_attack()
	
	# If not in range, stop timer. Transition to walk
	if mage.global_position.distance_to(player.global_position) > 550:
		$Timer.stop()
		Transitioned.emit(self, "walk")

func create_attack():
	# For loop 8 times, use Vector2.RIGHT.rotate(angle)
	for count in range(0, 8):
		var mage_attack = mage_attack_scene.instantiate()
		
		var angle = count * (360.0 / 8.0)
		mage_attack.direction = Vector2.RIGHT.rotated(deg_to_rad(angle)).normalized()
		
		mage.add_child(mage_attack) 
