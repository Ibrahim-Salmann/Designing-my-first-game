extends Node2D

class_name CombatSystem

@onready var player: Node = $".."

func _input(event):
	if player.is_attacking:
		return
	if Input.is_action_just_pressed("right_hand_action") or Input.is_action_just_pressed("left_hand_action"):
		player.play_attack_animation()
