extends Area2D

# Can be either a fire, water, or ice swirl
var element = "Fire"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_values_and_animate(start_pos, swirl_damage, status): 
	position = start_pos
	print(position)
	$AnimatedSprite2D.play(status)
	$AnimationPlayer.play("Default")

func remove():
	$AnimationPlayer.stop()
	if is_inside_tree():
		get_parent().remove_child(self)
		queue_free()
