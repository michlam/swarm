extends Node2D

@onready var health_bar: TextureProgressBar = $HealthBar
@export var enemy_goblin_scene: PackedScene

var health_bar_offset = Vector2(-33, -55)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.scale = Vector2(2, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_healthbar_helper()
	process_animation_helper()


func process_healthbar_helper():
		# Handle health bar always above player
	health_bar.position = $Player.position + health_bar_offset
	

func process_animation_helper():
	health_bar.value = $Player/Stats.health


func _on_mob_timer_timeout() -> void:
	var enemy_goblin = enemy_goblin_scene.instantiate()
	add_child(enemy_goblin) 
