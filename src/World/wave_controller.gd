extends Node2D

@export var world: Node2D
@export var enemy_goblin_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_mob_timer_timeout() -> void:
	var enemy_goblin = enemy_goblin_scene.instantiate()
	world.add_child(enemy_goblin) 
