extends Control

@onready var player = get_parent().find_child("Player")
@onready var player_stats = player.find_child("Stats")
@onready var skill_timer = player_stats.find_child("SkillTimer")
@onready var ultimate_timer = player_stats.find_child("UltimateTimer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Element.play("Fire")
	$CanvasLayer/SkillBorder/Label.text = "space"
	$CanvasLayer/UltimateBorder/Label.text = "R"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if skill_timer.time_left != 0:
		$CanvasLayer/SkillBorder/Label.text = str(int(skill_timer.time_left))
	else:
		$CanvasLayer/SkillBorder/Label.text = "space"
		
	if ultimate_timer.time_left != 0:
		$CanvasLayer/UltimateBorder/Label.text = str(int(ultimate_timer.time_left))
	else:
		$CanvasLayer/UltimateBorder/Label.text = "R"
		
func change_element(element):
	$CanvasLayer/Element.play(element)
