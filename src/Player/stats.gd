extends Node2D

# MEMBER VARIABLES
var level = 1
var experience = 0
var speed = 250

var max_health = 100
var health = max_health
var health_regen = 0

var elemental_mastery = 20.0 # Should start at 0
var wind_level = 1 # Should start at 0
var fire_level = 1 # Should start at 0
var water_level = 1 # Should start at 0
var ice_level = 1 # Should start at 0

var attack = 10
var crit_rate = 10
var crit_damage: float = 50.0

var element_switch_on_cooldown = false
var cooldown_reduction = 0

var unlocked_elements = ["Fire", "Ice"] # Fire, Water, Ice
var current_element = "Fire"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_element_switch()

func take_damage(amount):
	health = max(0, health - amount)
	
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
		print(current_element)

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

func is_crit_strike(damage):
	if randf_range(0, 100) < crit_rate:
		return floor(damage * ((100.0 + crit_damage) / 100.0))
	else:
		return damage
