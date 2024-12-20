extends State
class_name EnemyGolemStunned

@export var golem: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var element_status: Node2D
@onready var player = get_parent().get_parent().get_parent().find_child("Player")

var stunned

func Enter():
	sprite.stop()
	stunned = true
	if golem:
		golem.velocity = Vector2.ZERO

func Update(delta):
	if !stunned:
		Transitioned.emit(self, "walk")
		
func Physics_Update(delta):
	pass


func _on_stun_timer_timeout() -> void:
	stunned = false