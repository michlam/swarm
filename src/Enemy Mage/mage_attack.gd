extends Area2D


var speed = 350
var base_damage = 30

@export var sprite: AnimatedSprite2D
@onready var mage = get_parent()
@onready var world = mage.get_parent()
@onready var player = world.find_child("Player")

# Direction is set by parent on creation
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("Default")


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
