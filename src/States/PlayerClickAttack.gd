extends State
class_name ClickAttack

@export var player: CharacterBody2D
@export var ap: AnimationPlayer
@export var sprite: AnimatedSprite2D

var mouse_position

func _input(event):
	if event is InputEventMouseButton:
		mouse_position = event.position

func Enter():
	player.velocity = Vector2.ZERO
	# Handle attacking in the direction of the mouse
	if mouse_position.x < (player.screen_size.x / 2):
		player.scale.x = -0.65
	else:
		player.scale.x = 0.65
	
	sprite.play("Attack_Hori_1")
	ap.play("Attack_Hori_1")
	
func Update(delta):
	pass
	
func Physics_Update(delta):
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	Transitioned.emit(self, "idle")
