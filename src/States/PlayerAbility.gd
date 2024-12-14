extends State
class_name Ability

@export var player: CharacterBody2D
@export var player_stats: Node2D
@export var ability_timer: Timer

@export var fire_ability_scene: PackedScene
@export var ice_ability_scene: PackedScene
var ability_scene

func Enter():
	# Need an element to use ability
	if player_stats.current_element == "None":
		pass
	
	if player_stats.current_element == "Fire":
		ability_scene = fire_ability_scene.instantiate()
		add_child(ability_scene) 
		
	if player_stats.current_element == "Ice":
		ability_scene = ice_ability_scene.instantiate()
		add_child(ability_scene)
	
	# Find attack direction
	# Determine which elemental ability to use
	# Instantiate the correct ability scene
	pass
	
func Exit():
	pass
	
func Update(delta: float):
	ability_timer.start()
	Transitioned.emit(self, "idle")

func Physics_Update(delta: float):
	pass
