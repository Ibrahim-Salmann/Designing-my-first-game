extends CharacterBody2D

class_name Enemy

@export var speed: float = 100
@export var patrol_path: Array[Marker2D] = []
@export var patrol_wait_time = 1.0
@export var damage_to_player = 10

@export var health: int = 50
@export var item_to_drop: InventoryItem

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_system: HealthSystem = $HealthSystem

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@export var loot_stacks = 1

const PICKUP_ITEM_SCENE = preload("res://Product/Scenes/pickup_item.tscn")

var current_patrol_target = 0
var wait_timer = 0.0
