extends Area2D

var base_damage = 50

@export var sprite: AnimatedSprite2D
@export var ap: AnimationPlayer
@onready var player = get_parent().get_parent().find_child("Player")
@onready var player_stats = player.find_child("Stats")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("Default")
	ap.play("Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func remove():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage(player_stats.get_ability_damage(base_damage, "Ice"), "Ice")
