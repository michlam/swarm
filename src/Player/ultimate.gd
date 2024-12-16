extends State
class_name Ultimate

@export var player: CharacterBody2D
@export var player_stats: Node2D

@export var water_ultimate_scene: PackedScene

var ultimate_complete = true
var ultimate_scene

func Enter():
	# Need an element to use ultimate
	if player_stats.current_element == "None":
		pass
	
	if player_stats.current_element == "Fire":
		pass
		
	if player_stats.current_element == "Ice":
		for node in get_tree().get_nodes_in_group("enemies"):
			var status = node.find_child("ElementStatus")
			status.remove_status()
			status.stun()
		
	if player_stats.current_element == "Water":
		ultimate_complete = false
		ultimate_scene = water_ultimate_scene.instantiate()
		add_child(ultimate_scene) 
	
func Exit():
	pass
	
func Update(delta: float):
	if ultimate_complete:
		Transitioned.emit(self, "idle")

func Physics_Update(delta: float):
	pass
