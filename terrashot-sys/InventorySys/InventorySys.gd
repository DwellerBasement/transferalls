extends Resource

class_name Inv

signal update

@export var Slots: Array[InvSlot]

func insert(Item: InvItem):
	var ItemSlots = Slots.filter(func(slot): return slot.Item == Item)
	
	if !ItemSlots.is_empty():
		# FIX: Changed 'amount' to capital 'Amount' to match your InvSlot resource
		ItemSlots[0].Amount += 1 
	else:
		var EmptySlots = Slots.filter(func(slot): return slot.Item == null)
		
		if !EmptySlots.is_empty():
			EmptySlots[0].Item = Item 
			# FIX: Changed 'amount' to capital 'Amount' to match your InvSlot resource
			EmptySlots[0].Amount = 1
	
	update.emit()
