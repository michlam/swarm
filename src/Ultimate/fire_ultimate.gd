extends Area2D

var base_damage = 25
var max_damage = 1000

@export var sprite: AnimatedSprite2D
@export var line: Line2D
@export var ap: AnimationPlayer
@export var collision: CollisionShape2D
@onready var player = get_parent().get_parent().get_parent()
@onready var ultimate_node = get_parent()
@onready var player_stats = player.find_child("Stats")

var is_on = true
var last_cycle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_global_mouse_position()
	
	line.add_point(Vector2.ZERO)
	line.add_point(line.to_local(player.position))
	
	ap.play("Default")
	sprite.play("Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Input.is_action_pressed("ultimate"):
		last_cycle = true


func _on_timer_timeout() -> void:
	if last_cycle:
		ultimate_node.ultimate_complete = true
		queue_free()
	elif collision.disabled:
		base_damage = min(max_damage, base_damage * 2)
		collision.disabled = false
	elif !collision.disabled:
		collision.disabled = true


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") && body.name != "Player":
		body.take_damage(player_stats.get_ability_damage(base_damage, "Fire"), "Fire")
