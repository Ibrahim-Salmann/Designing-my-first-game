extends Node

class_name SpellSystem

var spell_configs: Array[SpellConfig] = [
	preload("res://Product/Resources/Spells/FireBall/fire_spell_config.tres"),
	preload("res://Product/Resources/Spells/Ice/ice_spell_config.tres")
]

const SPELL = preload("res://Product/Scenes/spell.tscn")

@onready var player: Player = $".."
@onready var inventory: Inventory = $"../Inventory"
@onready var on_screen_ui: OnScreenUI = $"../OnScreenUI"
@onready var combat_system: CombatSystem = $"../CombatSystem"

var current_spell_cooldown = null
var cooldown_timer := 0.0
var active_spell_index = -1

func _ready() -> void:
	print("SpellSystem ready, connecting signals...")
	inventory.spell_activated.connect(on_spell_activated)
	combat_system.cast_active_spell.connect(on_cast_active_spell)
	

func _process(delta: float) -> void:
	if current_spell_cooldown != null && cooldown_timer < current_spell_cooldown:
		cooldown_timer += delta

	

func on_cast_active_spell():
	
	if active_spell_index == -1:
		return # No spell is active
	
	var spell_direction = player.attack_vector
	var spell_config = spell_configs[active_spell_index]
	
	
	
	if current_spell_cooldown != null and cooldown_timer < current_spell_cooldown:
		return
	else: 
		cooldown_timer = 0
	
	on_screen_ui.spell_cooldown_activated(current_spell_cooldown)
	
	var spell_rotation = get_spell_rotation(spell_direction, spell_config.initial_rotation)
	var spell: Spell = SPELL.instantiate()
	
	
	
	#get_tree().root.add_child(spell)
	get_parent().add_child(spell)
	spell.rotation_degrees = spell_rotation
	spell.direction = spell_direction
	print("Casting spell:", spell_config.spell_name, "at", player.global_position, "with direction:", spell_direction)
	spell.init(spell_config)
	#spell.position = get_parent().global_position
	spell.global_position = player.global_position + (spell_direction * 16)
	

func get_spell_rotation(spell_direction: Vector2, initial_rotation: int):
	match spell_direction:
		Vector2.LEFT:
			return 180 + initial_rotation
		Vector2.RIGHT:
			return -180 + initial_rotation
		Vector2.UP:
			return 90 + initial_rotation
		Vector2.DOWN:
			return -90 + initial_rotation

func on_spell_activated(idx: int):
	active_spell_index = idx
	var spell_config = spell_configs[idx]
	on_screen_ui.toggle_spell_slot(true, spell_config.ui_texture)
	current_spell_cooldown = spell_config.initial_cooldown
