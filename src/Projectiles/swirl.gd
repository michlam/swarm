extends Area2D

# Can be either a fire, water, or ice swirl
var element
var damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_values_and_animate(start_pos, swirl_damage, status): 
	position = start_pos
	damage = swirl_damage
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
		body.take_damage(damage, element)
