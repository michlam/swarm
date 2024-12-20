extends Area2D


var speed = 350
var base_damage = 20

@export var sprite: AnimatedSprite2D
@onready var golem = get_parent()
@onready var world = golem.get_parent()
@onready var player = world.find_child("Player")

var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("Default")
	
	direction = player.global_position - global_position
	direction = direction.normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction:
		position += speed * direction * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name == "Player":
		body.take_damage(base_damage)
		queue_free()
