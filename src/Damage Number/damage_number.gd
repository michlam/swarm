extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_values_and_animate(value, start_pos, height, colour):
	$Label_Container/Label.text = str(value)
	$Label_Container/Label.label_settings.font_color = Color(colour)
	$AnimationPlayer.play("Damage_Number")
	
	var tween = get_tree().create_tween()
	var end_pos = start_pos - Vector2(0, height)
	var tween_length = $AnimationPlayer.get_animation("Damage_Number").length
	
	tween.tween_property($Label_Container, "position", end_pos, tween_length).from(start_pos)

func remove():
	$AnimationPlayer.stop()
	if is_inside_tree():
		get_parent().remove_child(self)
		queue_free()
