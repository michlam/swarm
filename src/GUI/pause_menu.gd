extends Control

@onready var canvas = $CanvasLayer
@onready var player = get_parent().find_child("Player")
@onready var player_stats = player.find_child("Stats")

var pause_menu_ready = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canvas.visible:
		update_stats()
		
		if pause_menu_ready && Input.is_action_just_pressed("pause"):
			canvas.visible = false
			pause_menu_ready = false
			get_tree().paused = false

func update_stats():
	$CanvasLayer/Level/Number.text = str(player_stats.level)
	$CanvasLayer/Experience/Number.text = str(player_stats.current_experience) + "/" + str(player_stats.experience_to_next_level)
	$CanvasLayer/Speed/Number.text = str(player_stats.speed)
	$CanvasLayer/HP/Number.text = str(player_stats.health) + "/" + str(player_stats.max_health)
	$"CanvasLayer/HP Regen/Number".text = str(player_stats.health_regen) + "/sec"
	$CanvasLayer/ATK/Number.text = str(player_stats.attack)
	$"CanvasLayer/CRIT RATE/Number".text = str(player_stats.crit_rate) + "%"
	$"CanvasLayer/CRIT DMG/Number".text = str(player_stats.crit_damage) + "%"
	$"CanvasLayer/Elemental Mastery/Number".text = str(player_stats.elemental_mastery) + "%"
	
	var cdr_percent = (1.0 - player_stats.cooldown_reduction) * 100
	$"CanvasLayer/CDR/Number".text = str(cdr_percent) + "%"
	
	$CanvasLayer/Fire/Number.text = str(player_stats.fire_level)
	$CanvasLayer/Water/Number.text = str(player_stats.water_level)
	$CanvasLayer/Ice/Number.text = str(player_stats.ice_level)
	$CanvasLayer/Wind/Number.text = str(player_stats.wind_level)

func _on_timer_timeout() -> void:
	pause_menu_ready = true
