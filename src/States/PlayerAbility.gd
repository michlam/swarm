extends State
class_name Passive

@export var player: CharacterBody2D
@export var player_stats: Node2D
@export var ability_timer: Timer

@export var fire_ability_scene: PackedScene
@export var ice_ability_scene: PackedScene
@export var water_ability_scene: PackedScene
var ability_scene

func Enter():
	# Need an element to use ability
	if player_stats.current_element == "None":
		return
	
	if player_stats.current_element == "Fire" && player_stats.fire_level >= 1:
		ability_scene = fire_ability_scene.instantiate()
		add_child(ability_scene) 
		
	if player_stats.current_element == "Ice" && player_stats.ice_level >= 1:
		ability_scene = ice_ability_scene.instantiate()
		add_child(ability_scene)
		
	if player_stats.current_element == "Water" && player_stats.water_level >= 1:
		ability_scene = water_ability_scene.instantiate()
		add_child(ability_scene)
	
func Exit():
	pass
	
func Update(delta: float):
	ability_timer.start()
	Transitioned.emit(self, "idle")

func Physics_Update(delta: float):
	pass
