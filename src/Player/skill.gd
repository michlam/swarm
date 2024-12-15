extends State
class_name Skill

@export var player: CharacterBody2D
@export var player_stats: Node2D

@export var fire_skill_scene: PackedScene
#@export var ice_skill_scene: PackedScene
@export var water_skill_scene: PackedScene
var skill_scene
var skill_complete = true

func Enter():
	# Need an element to use ability
	if player_stats.current_element == "None":
		pass
	
	if player_stats.current_element == "Fire":
		skill_complete = false
		skill_scene = fire_skill_scene.instantiate()
		add_child(skill_scene) 
		
	#if player_stats.current_element == "Ice":
		#skill_scene = ice_skill_scene.instantiate()
		#add_child(skill_scene)
		#
	if player_stats.current_element == "Water":
		skill_scene = water_skill_scene.instantiate()
		add_child(skill_scene)
	
func Exit():
	pass
	
func Update(delta: float):
	if skill_complete:
		Transitioned.emit(self, "idle")

func Physics_Update(delta: float):
	pass
