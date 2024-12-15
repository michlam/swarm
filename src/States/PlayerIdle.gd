extends State
class_name Idle

@export var player: CharacterBody2D
@export var player_stats: Node2D
@export var ap: AnimationPlayer
@export var sprite: AnimatedSprite2D
@export var skill_timer: Timer


func Enter():
	sprite.play("Idle")
	if player:
		player.velocity = Vector2.ZERO

func Update(delta):
	if Input.is_action_pressed("click_attack"):
		Transitioned.emit(self, "clickattack")
	elif Input.is_action_pressed("right_click"):
		pass
	elif (Input.is_action_just_pressed("skill") && !player_stats.skill_on_cooldown):
		player_stats.skill_on_cooldown = true
		skill_timer.start()
		Transitioned.emit(self, "skill")
	elif (Input.is_action_pressed("move_up") || Input.is_action_pressed("move_down") ||
		Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right")):
		Transitioned.emit(self, "walk")
		
func Physics_Update(delta):
	pass

func _on_ability_timer_timeout() -> void:
	Transitioned.emit(self, "passive")
