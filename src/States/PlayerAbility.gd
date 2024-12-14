extends State
class_name Ability

@export var player: CharacterBody2D
@export var player_stats: Node2D

func Enter():
	# Need an element to use ability
	if player_stats.current_element == "None":
		pass
	
	
	# Find attack direction
	# Determine which elemental ability to use
	# Instantiate the correct ability scene
	pass
	
func Exit():
	pass
	
func Update(delta: float):
	# Go back to idle
	Transitioned.emit(self, "idle")

func Physics_Update(delta: float):
	pass
