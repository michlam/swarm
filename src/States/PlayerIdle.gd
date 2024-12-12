extends State
class_name Idle

@export var player: CharacterBody2D
@export var ap: AnimationPlayer
@export var sprite: AnimatedSprite2D

func Enter():
	sprite.play("Idle")
	
	
func Update(delta):
	if Input.is_action_pressed("click_attack"):
		print("Click Attack")
	elif Input.is_anything_pressed():
		Transitioned.emit(self, "walk")
		
func Physics_Update(delta):
	if player:
		player.velocity = Vector2.ZERO
	
