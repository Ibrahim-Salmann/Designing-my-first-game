extends CanvasLayer

class_name OnScreenUI

@onready var right_hand_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/RightHandSlot
@onready var left_hand_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/LeftHandSlot
@onready var potion_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/PotionSlot
@onready var spell_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/SpellSlot
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

@onready var slots_dictionary = {
	"Right_Hand": right_hand_slot,
	"Left_Hand": left_hand_slot,
	"Potions": potion_slot
}

func equip_item(item: InventoryItem, slot_to_equip: String):
	slots_dictionary[slot_to_equip].set_equipment_texture(item.texture)
	
func toggle_spell_slot(is_visible: bool, ui_texture: Texture):
	spell_slot.visible = is_visible
	if is_visible:
		spell_slot.set_equipment_texture(ui_texture)

func spell_cooldown_activated(cooldown: float) -> void:
	print("Spell cooldown started:", cooldown)

func init_health_bar(max_health: int) -> void:
	progress_bar.max_value = max_health
	
func apply_damage_to_health_bar(damage: int):
	progress_bar.value -= damage
