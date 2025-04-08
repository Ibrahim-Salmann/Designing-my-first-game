extends CanvasLayer

class_name InventoryUI

@onready var grid_container: GridContainer = %GridContainer
const INVENTORY_SLOT_SCENE = preload("res://Product/Scenes/UI/inventory_slot.tscn")

@export var size = 8
@export var colums = 4

func _ready():
	grid_container.columns = colums
	
	for i in size:
		var inventory_slot = INVENTORY_SLOT_SCENE.instantiate()
		grid_container.add_child(inventory_slot)

func toggle():
	visible = !visible
	
 
