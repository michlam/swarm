extends Node

# Possible element status is None, Fire, Water, and Ice.
# Wind is not a status element, but only an applied element.
const status_elements = ["Fire", "Water", "Ice"]
var stunned = false

@onready var status = "None" # For testing purposes
@export var enemy_sprite: AnimatedSprite2D
@export var stun_sprite: Sprite2D

@onready var player_stats = get_parent().get_parent().find_child("Player").find_child("Stats")

# Reaction scenes
@export var swirl_scene: PackedScene

# There is a cooldown to elemental application. After a REACTION, there can be no application for
# the duration of the ICD
var on_cooldown = false

func _ready() -> void:
	change_overlay_colour()

	
func change_overlay_colour():
	var color = get_element_colour(status)
	enemy_sprite.modulate = color

func get_element_colour(element: String) -> Color:
	var color_string = "WHITE" # Physical damage
	
	match element:
		"Fire":
			color_string = "ORANGE_RED"
		"Water":
			color_string = "REBECCA_PURPLE"
		"Ice":
			color_string = "DODGER_BLUE"
		"Wind":
			color_string = "LIGHT_SEA_GREEN"
	
	return Color(color_string)


func _on_icd_timeout() -> void:
	on_cooldown = false
	

# Applies the elemental reaction based on current status. 
# Updates status, creates reaction damage nodes, updates ICD timer
# Returns any damage multiplier
func apply_element(applied_element: String) -> float:
	if status == "None" && !on_cooldown:
		if applied_element != "Wind":
			status = applied_element
			change_overlay_colour()
			
		return 1.0

	if applied_element == "None" || on_cooldown || applied_element == status:
		return 1.0
	else:
		# A REACTION HAPPENED!
		$ICD.start()
		on_cooldown = true
		var damage_multiplier = 1.0
		
		match applied_element:
			"Wind": # Swirl reaction
				var swirl = swirl_scene.instantiate()
				call_deferred("add_child", swirl) 
				swirl.set_values_and_animate(enemy_sprite.global_position, status)
		
			"Fire":
				if status == "Ice": # Melt reaction
					damage_multiplier = 2.0
				elif status == "Water": # Reverse vaporize reaction
					damage_multiplier = 1.5
			
			"Ice":
				if status == "Fire": # Reverse melt reaction
					damage_multiplier = 1.5
				if status == "Water": # Freeze reaction
					stunned = true
					stun_sprite.visible = true
					$Stun_Timer.start()
					pass
			
			"Water":
				if status == "Fire": # Vaporize reaction
					damage_multiplier = 2.0
				if status == "Ice": # Freeze Reaction
					stunned = true
					stun_sprite.visible = true
					$Stun_Timer.start()
					pass
		
		# Status should be set to none
		status = "None"
		change_overlay_colour()
		
		return damage_multiplier * ((100.0 + player_stats.elemental_mastery) / 100.0)


func _on_stun_timeout() -> void:
	stunned = false
	stun_sprite.visible = false
