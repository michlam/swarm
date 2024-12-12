extends State
class_name Idle

@export var player: CharacterBody2D
@export var ap: AnimationPlayer
@export var sprite: AnimatedSprite2D

func Enter():
	sprite.play("Idle")
	if player:
		player.velocity = Vector2.ZERO

func Update(delta):
	if Input.is_action_pressed("click_attack"):
		Transitioned.emit(self, "clickattack")
	elif Input.is_anything_pressed():
		Transitioned.emit(self, "walk")
		
func Physics_Update(delta):
	pass
