extends Node2D

# MEMBER VARIABLES
var level = 1
var experience = 0

var health = 100
var health_regen = 0

var attack = 10
var elemental_mastery = 0
var crit_rate = 0
var crit_damage = 0

var element_switch_on_cooldown = false
var cooldown_reduction = 0

var unlocked_elements = ["Fire", "Water", "Ice"] # Fire, Water, Ice
var current_element = "Fire"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_element_switch()


func handle_element_switch():
	# Handle element change with right click
	if (Input.is_action_pressed("right_click") 
	&& unlocked_elements.has(current_element) 
	&& !element_switch_on_cooldown):
		var next_index = (unlocked_elements.find(current_element) + 1) % unlocked_elements.size() 
		current_element = unlocked_elements[next_index]
		element_switch_on_cooldown = true
		$ElementSwitchTimer.start()

func _on_element_switch_timer_timeout() -> void:
	element_switch_on_cooldown = false
