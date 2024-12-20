extends Node2D

# MEMBER VARIABLES
var level = 1
var current_experience = 0
var experience_to_next_level = 200

var base_speed = 250
var speed = base_speed
var cooldown_reduction = 1.0 # 1 for no CDR, 0 for 100% CDR

var max_health = 300.0
var health = max_health
var health_regen = 1

var elemental_mastery = 0.0 # Should start at 0
var wind_level = 0 # Should start at 0
var fire_level = 0 # Should start at 0
var water_level = 0 # Should start at 0
var ice_level = 0 # Should start at 0

var attack = 10
var crit_rate = 10
var crit_damage: float = 50.0

var element_switch_on_cooldown = false

var unlocked_elements = ["Fire", "Water", "Ice"] # Fire, Water, Ice
var current_element = "Fire"

var skill_on_cooldown = false
var ultimate_on_cooldown = false
var is_invincible = false

@onready var gui_level_up = get_parent().get_parent().find_child("GUI_Level_Up")
@export var health_bar_ui: TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set the cooldown reduction
	update_cooldowns()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_element_switch()

func update_cooldowns():
	$PassiveTimer.wait_time = 3 * cooldown_reduction
	$SkillTimer.wait_time = 5 * cooldown_reduction
	$UltimateTimer.wait_time = 30 * cooldown_reduction

func take_damage(amount):
	if !is_invincible:
		health = max(0, health - amount)
		print("Player health: ", health)
	
func heal(amount):
	health = min(health + amount, max_health)
	
func handle_element_switch():
	# Handle element change with right click
	if (Input.is_action_just_pressed("right_click") 
	&& unlocked_elements.has(current_element) 
	&& !element_switch_on_cooldown):
		var next_index = (unlocked_elements.find(current_element) + 1) % unlocked_elements.size() 
		current_element = unlocked_elements[next_index]
		element_switch_on_cooldown = true
		$ElementSwitchTimer.start()
		print("Current Element: ", current_element)

func _on_element_switch_timer_timeout() -> void:
	element_switch_on_cooldown = false

func get_melee_damage():
	var return_damage = 0
	
	# Static melee multiplier is 3
	return_damage = 3 * attack
	return_damage = is_crit_strike(return_damage)
	
	return return_damage

func get_wind_damage(damage):
	var return_damage = 0
	
	return_damage = wind_level * damage
	return_damage = is_crit_strike(return_damage)
	
	return return_damage
	
func get_swirl_damage(damage): # Swirls cannot crit!
	var return_damage = 0
	
	return_damage = wind_level * damage
	return_damage = floor(return_damage * ((100.0 + elemental_mastery) / 100.0))
	
	return return_damage
	
func get_ability_damage(damage, type):
	var element_level = 0
	var return_damage = 0
	
	match type:
		"Fire":
			element_level = fire_level
		"Water":
			element_level = water_level
		"Ice":
			element_level = ice_level
	
	return_damage = element_level * damage
	return_damage = is_crit_strike(return_damage)
	
	return return_damage

func is_crit_strike(damage):
	if randf_range(0, 100) < crit_rate:
		return floor(damage * ((100.0 + crit_damage) / 100.0))
	else:
		return damage

func _on_skill_timer_timeout() -> void:
	skill_on_cooldown = false

func _on_ultimate_timer_timeout() -> void:
	ultimate_on_cooldown = false
	
func gain_exp(amount: int):
	current_experience += amount
	
	if current_experience > experience_to_next_level:
		level_up()
		current_experience -= experience_to_next_level
		experience_to_next_level = get_next_level_exp()


func get_next_level_exp():
	return ceil((200 * (level ** 2.2)) - (200 * level));


func level_up():
	level += 1
	get_tree().paused = true
	gui_level_up.find_child("CanvasLayer").visible = true
