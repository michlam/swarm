extends TextureProgressBar

@export var player: CharacterBody2D
@export var stats: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = player.position + Vector2(-25, -50)
	value = 100.0 * (float(stats.health) / float(stats.max_health))


#func process_healthbar_helper():
	## Handle health bar always above player
	#health_bar.position = $Player.position + health_bar_offset
	
