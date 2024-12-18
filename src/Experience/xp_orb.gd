extends Area2D

var exp_amount
var in_range = false
var speed = 300

@export var sprite: AnimatedSprite2D
@onready var player = get_parent().get_parent().find_child("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("exp")
	sprite.play("Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_range:
		var direction = find_direction()
		position += speed * direction.normalized() * delta

	
func find_direction() -> Vector2:	
	return player.position - position
