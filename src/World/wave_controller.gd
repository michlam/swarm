extends Node2D

@export var world: Node2D
@export var enemy_goblin_scene: PackedScene

var current_wave = 1
var power_budget = 300

var tank_unlocked = false
var goblin_unlocked = true

# We have a power budget to allocate to each wave.
# Every mob just scales in HP, not damage.
# Every time MobTimer times out, choose a mob type and location
# For each new wave, unlock a new spawner location - global
# For every mob created, subtract the given HP from the power budget
# When power budget < 0:
#	Increment current wave
#	Find new power budget

func _on_mob_timer_timeout() -> void:
	var new_enemy = create_enemy()
	# enemy position = choose_position()
	new_enemy.max_health = current_wave * 100
	new_enemy.current_health = new_enemy.max_health
	world.add_child(new_enemy) 
	
	power_budget = max(0, power_budget - new_enemy.max_health)
	if power_budget <= 0:
		current_wave += 1
		power_budget = find_power_budget()
		print("New wave: ", current_wave, " Power Budget: ", power_budget)

func unlock_enemy():
	if current_wave >= 1:
		goblin_unlocked = true

func create_enemy():
	if tank_unlocked:
		# 5% chance of creating a tank, 95% chance of creating goblin
		pass
	elif goblin_unlocked:
		# 100% chance of creating goblin
		return enemy_goblin_scene.instantiate()
		

func find_power_budget():
	return ceil(300 * (current_wave ** 2.2) - 200 * current_wave)
