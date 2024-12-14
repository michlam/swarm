extends State
class_name Walk

@export var player: CharacterBody2D
@export var ap: AnimationPlayer
@export var sprite: AnimatedSprite2D

func Enter():
	sprite.play("Walk")
	
func Update(delta):
	if !Input.is_anything_pressed():
		Transitioned.emit(self, "idle")
	elif Input.is_action_just_pressed("ability"):
		Transitioned.emit(self, "ability")
	elif Input.is_action_pressed("click_attack"):
		Transitioned.emit(self, "clickattack")
	
func Physics_Update(delta):
	# Handle basic movement based on key input
	player.velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		player.velocity.x += 1
	if Input.is_action_pressed("move_left"):
		player.velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		player.velocity.y += 1
	if Input.is_action_pressed("move_up"):
		player.velocity.y -= 1
		
	player.velocity = player.velocity.normalized() * player.speed
	player.position += player.velocity * delta
