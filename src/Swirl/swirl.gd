extends Area2D

# Can be either a fire, water, or ice swirl
var element = "Fire"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_values_and_animate(swirl_damage, status): 
	$AnimatedSprite2D.play(status)
