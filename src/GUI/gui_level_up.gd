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
	player_stats.update_cooldowns()
	canvas.visible = false
	get_tree().paused = false

func _on_fire_button_pressed() -> void:
	if !$CanvasLayer.visible:
		return
	
	if $CanvasLayer/FireButton/Level.text == "5":
		return
	
	player_stats.fire_level += 1
	$CanvasLayer/FireButton/Level.text = str(player_stats.fire_level)
	end_level_up()


func _on_water_button_pressed() -> void:
	if !$CanvasLayer.visible:
		return
	
	if $CanvasLayer/WaterButton/Level.text == "5":
		return
	
	player_stats.water_level += 1
	$CanvasLayer/WaterButton/Level.text = str(player_stats.water_level)
	end_level_up()


func _on_ice_button_pressed() -> void:
	if !$CanvasLayer.visible:
		return
	
	if $CanvasLayer/IceButton/Level.text == "5":
		return
	
	player_stats.ice_level += 1
	$CanvasLayer/IceButton/Level.text = str(player_stats.ice_level)
	end_level_up()


func _on_wind_button_pressed() -> void:
	if !$CanvasLayer.visible:
		return
	
	if $CanvasLayer/WindButton/Level.text == "5":
		return
	
	player_stats.wind_level += 1
	$CanvasLayer/WindButton/Level.text = str(player_stats.wind_level)
	end_level_up()


func _on_strength_button_pressed() -> void:
	if !$CanvasLayer.visible:
		return
	
	# Strength increases attack, crit_rate, and crit_damage
	player_stats.attack += 10
	player_stats.crit_rate = min(100, player_stats.crit_rate + 15)
	player_stats.crit_damage += 30
	
	# Update the level, no cap
	var current_level = int($CanvasLayer/StrengthButton/Level.text)
	$CanvasLayer/StrengthButton/Level.text = str(current_level + 1)
	end_level_up()


func _on_vitality_button_pressed() -> void:
	if !$CanvasLayer.visible:
		return
	
	# Vitality increases max_health and health_regen
	player_stats.max_health += 75
	player_stats.health_regen += 1
	
	# Update the level, no cap
	var current_level = int($CanvasLayer/VitalityButton/Level.text)
	$CanvasLayer/VitalityButton/Level.text = str(current_level + 1)
	end_level_up()


func _on_utility_button_pressed() -> void:
	if !$CanvasLayer.visible:
		return
	
	# Utility increases speed, cooldown_reduction, and elemental_mastery 
	player_stats.speed += 15
	player_stats.cooldown_reduction *= 0.85
	player_stats.elemental_mastery += 40
	
	# Update the level, no cap
	var current_level = int($CanvasLayer/UtilityButton/Level.text)
	$CanvasLayer/UtilityButton/Level.text = str(current_level + 1)
	end_level_up()
