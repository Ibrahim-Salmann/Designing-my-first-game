extends CharacterBody2D

class_name Player

const SPEED = 100.0

signal attack_animation_finished

# Reference to the AnimatedSprite2D node
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory: Inventory = $Inventory
# To store the last movement direction for idle animation

@onready var health_system: HealthSystem = $HealthSystem
@onready var on_screen_ui: OnScreenUI = $OnScreenUI
@onready var combat_system: CombatSystem = $CombatSystem

var is_attacking: bool = false

@export var health = 100

#var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	health_system.init(health)
	health_system.died.connect(on_player_dead)
	health_system.damage_taken.connect(on_damage_taken)
	on_screen_ui.init_health_bar(health)

func on_player_dead():
	set_physics_process(false)
	combat_system.set_process_input(false)
	animated_sprite.play("dead")

func on_damage_taken(damage: int) -> void:
	on_screen_ui.apply_damage_to_health_bar(damage)

# Attack animation
const DIRECTION_TO_ATTACK_ANIMATION = {
	"down": "Attack_down",
	"up": "Attack_up",
	"left": "Attack_left",
	"right": "Attack_right"
}

# Attack Animation Vector
const DIRECTION_TO_ATTACK_VECTOR = {
	"down": Vector2(0, -1),
	"up": Vector2(0, 1),
	"left": Vector2(1, 0),
	"right": Vector2(-1, 0)
}

var last_direction: String = "down"

var attack_animation = null

var item_eject_direction = Vector2.DOWN

var attack_vector:
	get:
		return DIRECTION_TO_ATTACK_VECTOR.get(last_direction, Vector2.ZERO)


func _physics_process(delta: float) -> void:
	# Handle player movement
	if not is_attacking:
		player_movement(delta)
	handle_animation()
	
func player_movement(_delta: float) -> void:
	# Get input for horizontal and vertical movement
	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	print(input_vector)

	# Normalize the vector to ensure consistent speed in all directions
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		#item_eject_direction = input_vector # Update ejection direction to match player movement
		
		# Only update eject direction if input is strong enough
		if input_vector.length() > 0.2:
			item_eject_direction = input_vector

	# Set velocity based on input
	velocity = input_vector * SPEED
	
	# Move the character using move_and_slide()
	move_and_slide()
	
	# Update the last movement direction if the player is moving
	if input_vector != Vector2.ZERO:
		last_direction = get_direction(input_vector)
	
func get_direction(input_vector: Vector2) -> String:
	# Determine the direction based on the input vector
	if abs(input_vector.x) > abs(input_vector.y):
		return "right" if input_vector.x < 0 else "left"
	else:
		return "up" if input_vector.y < 0 else "down"

func handle_animation() -> void:
	if is_attacking: return  # Prevent animation override during attack
	if velocity == Vector2.ZERO:
		# Play idle animation based on last movement direction
		animated_sprite.play("Idle_" + last_direction)
	else:
		# Play running animation based on current direction
		animated_sprite.play("Run_" + get_direction(velocity.normalized()))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is PickUpItem:
		# Error fixed: syntex error
		inventory.add_item(area.inventory_item, area.stacks)
		area.queue_free()
		
	if area.get_parent() is Enemy:
		var damage_to_player = (area.get_parent() as Enemy).damage_to_player
		health_system.apply_damage(damage_to_player)

# Attack Animation
func play_attack_animation():
	if DIRECTION_TO_ATTACK_ANIMATION.has(last_direction) and not is_attacking:
		is_attacking = true
		animated_sprite.play(DIRECTION_TO_ATTACK_ANIMATION[last_direction])

#func _on_AnimatedSprite2D_animation_finished():
	#if animated_sprite.animation.begins_with("Attack"):
		#is_attacking = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation.begins_with("Attack"):
		is_attacking = false
		# Added for combat_system.gd
		attack_animation_finished.emit()

@export var attack_direction: String:
	get:
		match last_direction:
			"up": return "back"
			"down": return "front"
			_: return last_direction

func setup_test_inventory():
	const GOLD_INVENTORY_ITEM = preload("res://Product/Resources/GoldCoin/gold_coin.tres")
	const SWORD_INVENTORY_ITEM = preload("res://Product/Resources/Weapons/Sword/sword_inventory_item.tres")
	
	inventory.add_item(SWORD_INVENTORY_ITEM, 1)
	inventory.add_item(GOLD_INVENTORY_ITEM, 100)
	
