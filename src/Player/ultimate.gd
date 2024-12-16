extends State
class_name Ultimate

@export var player: CharacterBody2D
@export var player_stats: Node2D

var ultimate_complete = true

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
		pass
	
func Exit():
	pass
	
func Update(delta: float):
	if ultimate_complete:
		Transitioned.emit(self, "idle")

func Physics_Update(delta: float):
	pass
