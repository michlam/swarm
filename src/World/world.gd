extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		$GUI_Pause_Menu/Timer.start()
		$GUI_Pause_Menu/CanvasLayer.visible = true
