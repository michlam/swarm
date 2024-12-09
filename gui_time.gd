extends Control

@export_range(0, 59) var seconds: int = 0
@export_range(0, 59) var minutes: int = 0

@onready var time_label = $CanvasLayer/ClockControl/Label

var delta_time: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_time += delta
	if delta_time < 1: return
	
	var delta_int_secs: int = delta_time
	delta_time -= delta_int_secs
	
	seconds += delta_int_secs
	minutes += seconds / 60
	
	seconds = seconds % 60
	minutes = minutes % 60
	
	print_debug(str(minutes), ":", str(seconds))
	var seconds_string = "0" + str(seconds)	
	var minutes_string = "0" + str(minutes)
	print(minutes_string.right(2) + ":" + seconds_string.right(2))
	time_label.text = minutes_string.right(2) + ":" + seconds_string.right(2) 
