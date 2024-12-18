extends Control

@onready var canvas = find_child("CanvasLayer")
@onready var player = get_parent().find_child("Player")
@onready var player_stats = player.find_child("Stats")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func end_level_up():
	canvas.visible = false
	get_tree().paused = false

func _on_fire_button_pressed() -> void:
	print("fire level up button pressed")
	if !$CanvasLayer.visible:
		return
	
	if $CanvasLayer/FireButton/Level.text == "5":
		return
	
	player_stats.fire_level += 1
	$CanvasLayer/FireButton/Level.text = str(player_stats.fire_level)
	end_level_up()
	
	
	
