extends Control

@onready var Inv: Inv = preload("res://InventorySys/PlayerInv.tres")
@onready var Slots: Array = $NinePatchRect/GridContainer.get_children()

var IsOpen = false

func _ready() -> void:
	Inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(Inv.Slots.size(), Slots.size())):
		Slots[i].update(Inv.Slots[i])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('E'):
		if IsOpen:
			close()
			
		else:
			open()
	 
func open():
	visible = true
	IsOpen = true
	
func close():
	visible = false
	IsOpen = false
