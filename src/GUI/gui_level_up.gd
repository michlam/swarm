extends Control

@onready var canvas = find_child("CanvasLayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canvas.visible:
		print("hello")
		position = DisplayServer.screen_get_size() / 2
