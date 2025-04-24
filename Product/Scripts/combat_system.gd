extends Node2D

class_name CombatSystem

signal cast_active_spell

@onready var player: Player = $".."
@onready var right_hand_weapon_sprite: Sprite2D = $RightHandWeaponSprite
@onready var left_hand_weapon_sprite: Sprite2D = $LeftHandWeaponSprite
@onready var right_hand_collision_shape_2d: CollisionShape2D = $RightHandWeaponSprite/Area2D/CollisionShape2D
@onready var left_hand_collision_shape_2d: CollisionShape2D = $LeftHandWeaponSprite/Area2D/CollisionShape2D

@export var right_weapon: WeaponItem
@export var left_weapon: WeaponItem

var can_attack = true

func _ready() -> void:
	player.attack_animation_finished.connect(on_attack_animation_finished)
	right_hand_weapon_sprite.visible = false
	left_hand_weapon_sprite.visible = false
	
func _input(event):
	if player.is_attacking or !can_attack:
		return
	if Input.is_action_just_pressed("right_hand_action"):
		if right_weapon == null:
			return
		can_attack = false
		player.play_attack_animation()
		_set_weapon_pose(right_weapon, right_hand_weapon_sprite, player.attack_direction)
		
		#var attack_direction = player.attack_direction
		#var attack_data = right_weapon.get_data_for_direction(attack_direction)
		#
		#right_hand_weapon_sprite.position = attack_data.get("attachment_position")
		#right_hand_weapon_sprite.rotation_degrees = attack_data.get("rotation")
		#right_hand_weapon_sprite.z_index = attack_data.get("z_index")
		
	if Input.is_action_just_pressed("left_hand_action"):
		if left_weapon == null:
			return
		can_attack = false
		player.play_attack_animation()
		_set_weapon_pose(left_weapon, left_hand_weapon_sprite, player.attack_direction)
		
		#var attack_direction = player.attack_direction
		#var attack_data = left_weapon.get_data_for_direction(attack_direction)
		#
		#left_hand_weapon_sprite.position = attack_data.get("attachment_position")
		#left_hand_weapon_sprite.rotation_degrees = attack_data.get("rotation")
		#left_hand_weapon_sprite.z_index = attack_data.get("z_index")
		

func set_active_weapon(weapon: WeaponItem, slot_to_equip: String):
	if slot_to_equip == "Left_Hand":
		if weapon.collision_shape != null:
			left_hand_collision_shape_2d.shape = weapon.collision_shape
			
		left_hand_weapon_sprite.texture= weapon.in_hand_texture
		left_weapon = weapon
	
	elif slot_to_equip == "Right_Hand":
		if weapon.collision_shape != null:
			right_hand_collision_shape_2d.shape = weapon.collision_shape
			
		right_hand_weapon_sprite.texture = weapon.in_hand_texture
		right_weapon = weapon
		
	

func on_attack_animation_finished():
	can_attack = true
	right_hand_weapon_sprite.visible = false
	left_hand_weapon_sprite.visible = false

func _set_weapon_pose(weapon: WeaponItem, sprite: Sprite2D, direction: String):
	var data = weapon.get_data_for_direction(direction)
	sprite.position = data.get("attachment_position", Vector2.ZERO)
	sprite.rotation_degrees = data.get("rotation", 0)
	sprite.z_index = data.get("z_index", 0)
	sprite.visible = true  # Show sword during attack
	
	if weapon.attack_type == "Magic":
		cast_active_spell.emit()
