extends CanvasLayer

class_name ShoppingUI

var items_to_buy: Array[InventoryItem]
var items_to_sell: Array[InventoryItem]

var selected_sell_item_indexes: Array[int] = []
var selected_buy_item_indexes: Array[int] = []

const INVENTORY_SLOT_SCENE = preload("res://Product/Scenes/UI/inventory_slot.tscn")
var gold_coin_inventory_item  = preload("res://Product/Resources/GoldCoin/gold_coin.tres")

@onready var buying_grid_container: GridContainer = %BuyingGridContainer
@onready var selling_grid_container: GridContainer = %SellingGridContainer

@onready var buy_button: Button = %BuyButton
@onready var sell_button: Button = %SellButton



func setup_buying_grid():
	for child in buying_grid_container.get_children():
		child.queue_free()
		
	for i in range(items_to_buy.size()):
		var buying_slot = INVENTORY_SLOT_SCENE.instantiate() as InventorySlot
		buying_slot.my_index = i
		buying_slot.slot_clicked.connect(on_buy_slot_clicked) 
		buying_slot.single_button_press = true
		buying_grid_container.add_child(buying_slot)
		buying_slot.add_item(items_to_buy[i])
		buying_slot.show_price_tag(items_to_buy[i].price * items_to_buy[i].stacks)
		#buying_slot.slot_clicked.connect(on_buy_slot_clicked.bind(i))
		

func setup_selling_grid():
	
	for child in selling_grid_container.get_children():
		child.queue_free()
		
	for i in range(items_to_sell.size()):
		var selling_slot = INVENTORY_SLOT_SCENE.instantiate() as InventorySlot
		selling_slot.my_index = i 
		selling_slot.slot_clicked.connect(on_selling_slot_clicked)
		selling_slot.single_button_press = true
		selling_grid_container.add_child(selling_slot)
		selling_slot.add_item(items_to_sell[i])
		selling_slot.show_price_tag(items_to_sell[i].price * items_to_sell[i].stacks)
		#selling_slot.slot_clicked.connect(on_selling_slot_clicked.bind(i))
		

func on_buy_slot_clicked(idx: int):
	if selected_buy_item_indexes.has(idx):
		buying_grid_container.get_child(idx).toggle_button_selected_variation(false)
		selected_buy_item_indexes.erase(idx)
	else:
		buying_grid_container.get_child(idx).toggle_button_selected_variation(true)
		selected_buy_item_indexes.append(idx)
	
	buy_button.disabled = selected_buy_item_indexes.size() == 0
	

func on_selling_slot_clicked(idx: int):
	if selected_sell_item_indexes.has(idx):
		selling_grid_container.get_child(idx).toggle_button_selected_variation(false)
		selected_sell_item_indexes.erase(idx)
	else:
		selling_grid_container.get_child(idx).toggle_button_selected_variation(true)
		selected_sell_item_indexes.append(idx)
	
	sell_button.disabled = selected_sell_item_indexes.size() == 0
	




func _on_buy_button_pressed() -> void:
	
	var player = get_tree().get_first_node_in_group("player") as Player
	var inventory = player.find_child("Inventory") as Inventory

	# Find how much gold the player has
	var player_gold_item = inventory.find_item_by_resource(gold_coin_inventory_item)
	var player_gold = 0
	if player_gold_item:
		player_gold = player_gold_item.stacks
	
	for i in selected_buy_item_indexes.duplicate(): # Duplicate because we modify inside loop
		var item_to_buy = items_to_buy[i]
		var item_total_price = item_to_buy.price * item_to_buy.stacks
		
		# Check if player has enough gold
		if player_gold >= item_total_price:
			# Deduct gold from player
			player_gold -= item_total_price
			player_gold_item.stacks = player_gold  # Update gold item in inventory
			
			# Give item to player
			inventory.add_item(item_to_buy, item_to_buy.stacks)
			
			# Transfer gold to merchant
			var merchant = get_tree().get_first_node_in_group("merchant") as Merchant
			var gold_to_add_to_merchant_inventory = item_total_price
			var gold_coin = gold_coin_inventory_item.duplicate()
			gold_coin_inventory_item.stacks = gold_to_add_to_merchant_inventory
			merchant.items_to_buy.erase(item_to_buy)
			merchant.items_to_buy.append(gold_coin_inventory_item)
			
			# Remove item from shop UI
			buying_grid_container.get_child(i).queue_free()
			selected_buy_item_indexes.erase(i)
		else:
			print("Not enough gold to buy item:", item_to_buy.name)
	
	selected_buy_item_indexes.clear()
	selected_sell_item_indexes.clear()
	setup_buying_grid()
	setup_selling_grid()
	buy_button.disabled = true
	


func _on_sell_button_pressed() -> void:
	var merchant = get_tree().get_first_node_in_group("merchant") as Merchant
	var player = get_tree().get_first_node_in_group("player") as Player
	var inventory = (player.find_child("Inventory") as Inventory)
	for i in selected_sell_item_indexes.duplicate():
		var item_to_sell = items_to_sell[i]
		selling_grid_container.get_child(i).queue_free()
		#var current_items_in_player_inventory = inventory.items
		#current_items_in_player_inventory.erase(item_to_sell)
		#inventory.items = current_items_in_player_inventory
		#inventory.clear_inventory_slot(i)
		inventory.remove_item(item_to_sell)
		selected_sell_item_indexes.erase(i)
		merchant.items_to_buy.append(item_to_sell)
		
		var gold_to_add_to_player = item_to_sell.price * item_to_sell.stacks
		var gold_coin = gold_coin_inventory_item.duplicate()
		gold_coin.stacks = gold_to_add_to_player
		inventory.add_item(gold_coin, gold_coin.stacks)
	
	items_to_buy = merchant.items_to_buy
	selected_buy_item_indexes.clear()
	selected_sell_item_indexes.clear()
	setup_buying_grid()
	setup_selling_grid()
	sell_button.disabled = true
