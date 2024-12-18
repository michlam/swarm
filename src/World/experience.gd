extends Node2D

@export var xp_orb_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_xp_orb(amount, startPos):
	print("Create xp orb")
	var xp_orb = xp_orb_scene.instantiate()
	call_deferred("add_child", xp_orb)
	xp_orb.position = startPos
	xp_orb.exp_amount = amount
