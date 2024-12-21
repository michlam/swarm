extends State
class_name ClickAttack

@export var player: CharacterBody2D
@export var player_stats: Node2D
@export var ap: AnimationPlayer
@export var sprite: AnimatedSprite2D

@export var wind_blade_scene: PackedScene

var mouse_position
var number_of_attacks = 0

func Enter():
	player.velocity = Vector2.ZERO
	find_attack_direction()
	
	create_wind_blade()
	
func Update(delta):
	pass
	
func Physics_Update(delta):
	pass
	
func create_wind_blade():
	number_of_attacks += 1
	
	if player_stats.wind_level == 0:
		return
	
	if (number_of_attacks % (6 - player_stats.wind_level) == 0):
		var wind_blade_temp = wind_blade_scene.instantiate()
		add_child(wind_blade_temp) 

func _on_animated_sprite_2d_animation_finished() -> void:
	Transitioned.emit(self, "idle")
	
func find_attack_direction():
	# Handle attacking in the direction of the mouse
	player.check_screen_size()
	var screen_center = player.screen_size / 2
	var slope = player.screen_size.y / player.screen_size.x
	
	mouse_position = get_viewport().get_mouse_position()
	
	# Determine zone, like an X on the screen
	if abs(mouse_position.y - screen_center.y) < slope * abs(mouse_position.x - screen_center.x):
		# Left and right sections
		if mouse_position.x < screen_center.x:
			# Left side
			if sprite.flip_h: # Facing left, hit forward
				sprite.play("Attack_Hori_1")
				ap.play("Attack_Hori_2")
			else: # Facing left, hit backwards
				sprite.play("Attack_Hori_2")
				ap.play("Attack_Hori_2")
		else:
			# Right side
			if !sprite.flip_h: #Facing right, hit forward
				sprite.play("Attack_Hori_1")
				ap.play("Attack_Hori_1")
			else: # Facing right, hit backwards
				sprite.play("Attack_Hori_2")
				ap.play("Attack_Hori_1")
	else:
		# Top and bottom sections
		if mouse_position.y > screen_center.y:
			# Bottom section
			sprite.play("Attack_Down_1")
			ap.play("Attack_Down_1")
		else:
			# Top section
			sprite.play("Attack_Up_1")
			ap.play("Attack_Up_1")


func _on_ability_timer_timeout() -> void:
	Transitioned.emit(self, "passive")
