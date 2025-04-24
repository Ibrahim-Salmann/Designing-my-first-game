extends VBoxContainer

class_name InventorySlot
 
var is_empty = true
var is_selected = false

signal equip_item 
signal drop_item

signal slot_clicked

@export var single_button_press = false
@export var starting_texture: Texture
@export var start_label: String

@onready var texture_rect: TextureRect = $NinePatchRect/MenuButton/CenterContainer/TextureRect
@onready var name_label: Label = $NameLabel
@onready var stacks_label: Label = $NinePatchRect/StacksLabel
@onready var on_click_button: Button = $NinePatchRect/OnClickbutton
@onready var price_label: Label = $PriceLabel
@onready var menu_button: MenuButton = $NinePatchRect/MenuButton

var slot_to_equip = "NotEquipable"

func _ready() -> void:
	
	if starting_texture != null:
		texture_rect.texture = starting_texture
		
	if start_label != null:
		name_label.text = start_label
	
	#menu_button.disable = single_button_press
	on_click_button.disabled = !single_button_press
	
	on_click_button.visible = single_button_press
	
	menu_button.disabled = single_button_press
	
	
	var popup_menu = menu_button.get_popup()
	popup_menu.id_pressed.connect(on_popup_menu_item_pressed)
	
	

func on_popup_menu_item_pressed(id: int):
	var pressed_menu_item = menu_button.get_popup().get_item_text(id)
	
	if pressed_menu_item == "Drop":
		drop_item.emit()
		menu_button.disabled = true
	elif pressed_menu_item.contains("Equip") && slot_to_equip != "NotEquipable":
		equip_item.emit(slot_to_equip)
	#print_debug(id)
	

func add_item(item: InventoryItem):
	if item.slot_type != "NotEquipable":
		var popup_menu: PopupMenu = menu_button.get_popup()
		var equip_slot_array_name = item.slot_type.to_lower().split("_")
		var equip_slot_name = " ".join(equip_slot_array_name)
		slot_to_equip = item.slot_type
		# Syntext Error fixed: expected two arguments but got three. Removed the comma after "Equip to"
		popup_menu.set_item_text(0, "Equip to " + equip_slot_name)
		
	is_empty = false
	menu_button.disabled = false
	texture_rect.texture = item.texture
	name_label.text = item.name
	if item.stacks < 2:
		return
	
	stacks_label.text = str(item.stacks)
	
	
func clear_slot():
	is_empty = true
	slot_to_equip = "NotEquipable"
	texture_rect.texture = null
	name_label.text = ""
	stacks_label.text = ""
	menu_button.disabled = true


func _on_on_clickbutton_pressed() -> void:
	slot_clicked.emit()
	

func toggle_button_selected_variation(is_selected: bool):
	on_click_button.theme_type_variation = "selected" if is_selected else ""
