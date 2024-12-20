extends Node2D

@export var world: Node2D
@export var enemy_mage_scene: PackedScene
@export var enemy_goblin_scene: PackedScene
@export var enemy_golem_scene: PackedScene

var current_wave = 1
var power_budget = 300

var mage_unlocked = false
var golem_unlocked = false
var goblin_unlocked = true

@onready var spawner = $"Spawners/1"

func _on_mob_timer_timeout() -> void:
	var new_enemy = choose_enemy()
	setup_enemy(new_enemy)
	
	power_budget = max(0, power_budget - new_enemy.max_health)
	if power_budget <= 0: # New wave
		current_wave += 1
		power_budget = find_power_budget()
		spawner = choose_spawner()
		print("Current wave: ", current_wave, " uses spawner: ", spawner)
		unlock_enemy()
		
func setup_enemy(new_enemy):
	if new_enemy.type == "Goblin":
		new_enemy.max_health = current_wave * 100
	if new_enemy.type == "Mage":
		new_enemy.max_health = current_wave * 50
	if new_enemy.type == "Golem":
		new_enemy.max_health = current_wave * 1000

	new_enemy.global_position = spawner.global_position
	new_enemy.current_health = new_enemy.max_health
	world.add_child(new_enemy)

func unlock_enemy():
	if current_wave >= 1:
		goblin_unlocked = true
	if current_wave >= 5:
		mage_unlocked = true
	if current_wave >= 8:
		golem_unlocked = true

func choose_enemy():
	if golem_unlocked:
		# 5% chance for mage, 2% chance of golem, 93% chance of goblin
		var chance = randi_range(0, 100)
		if chance <= 93:
			return enemy_goblin_scene.instantiate()
		elif chance <= 98:
			return enemy_mage_scene.instantiate()
		else:
			return enemy_golem_scene.instantiate()
	if mage_unlocked:
		# 5% chance of creating a mage, 95% chance of creating goblin
		if randi_range(0, 100) <= 95:
			return enemy_goblin_scene.instantiate()
		else:
			return enemy_mage_scene.instantiate()
	elif goblin_unlocked:
		# 100% chance of creating goblin
		return enemy_goblin_scene.instantiate()

func find_power_budget():
	return ceil(300 * (current_wave ** 2.2) - 200 * current_wave)

func choose_spawner():
	var spawners = get_tree().get_nodes_in_group("spawners")
	
	if current_wave <= 13:
		return spawners[current_wave - 1]
	else:
		var index = randi_range(0, current_wave - 1) % spawners.size()
		return spawners[index]
