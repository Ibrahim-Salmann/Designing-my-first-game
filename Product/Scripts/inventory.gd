extends Node

class_name Inventory

@onready var inventory_ui: InventoryUI = $"../InventoryUI"

@export var items: Array[InventoryItem] = []

func _ready() -> void:
	inventory_ui.equip_item.connect(on_item_equipped)

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		inventory_ui.toggle()

func add_item(item: InventoryItem, stacks: int):
	if stacks && item.max_stack > 1:
		add_stackable_item_to_inventory(item, stacks)
	else:
		# Syntext Error
		items.append(item)
		inventory_ui.add_item(item)
		
		
		
func add_stackable_item_to_inventory(item: InventoryItem, stacks: int):
	var item_index = -1
	for i in items.size():
		if items[i] != null and items[i].name == item.name:
			item_index = i
			
	if item_index != -1:
		var inventory_item = items[item_index]
		
		if inventory_item.stacks + stacks <= item.max_stack:
			inventory_item.stacks += stacks
			items[item_index] = inventory_item
			inventory_ui.update_stack_at_slot_index(inventory_item.stacks, item_index)
		else:
			var stacks_diff = inventory_item.stacks + stacks - item.max_stack
			var additional_inventory_item = inventory_item.duplicate(true)
			inventory_item.stacks = item.max_stack
			inventory_ui.update_stack_at_slot_index(inventory_item.stacks, item_index)
			additional_inventory_item.stacks = stacks_diff
			# error fixed: syntex error
			items.append(additional_inventory_item)
			inventory_ui.add_item(additional_inventory_item)
			
	else:
		item.stacks = stacks
		items.append(item)
		inventory_ui.add_item(item)

func on_item_equipped(idx: int, slot_to_equip):
	var item_to_equip = items[idx]
	print_debug(item_to_equip)
