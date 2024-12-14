extends Area2D

@onready var player = get_parent().get_parent().get_parent()
@onready var player_stats = player.find_child("Stats")

# Can be either a fire, water, or ice swirl
var element
var base_damage = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_values_and_animate(start_pos, status): 
	position = start_pos
	element = status
	$AnimatedSprite2D.play(status)
	$AnimationPlayer.play("Default")

func remove():
	$AnimationPlayer.stop()
	if is_inside_tree():
		get_parent().remove_child(self)
		queue_free()

# Handles the damage
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage(player_stats.get_swirl_damage(base_damage), element)
