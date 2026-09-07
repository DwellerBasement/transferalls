extends Panel

@onready var ItemVisual: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var AmountText: Label = $CenterContainer/Panel/Label 

func update(Slots: InvSlot):
	if !Slots.Item:
		ItemVisual.visible = false
		AmountText.visible = false
	else:
		ItemVisual.visible = true
		ItemVisual.texture = Slots.Item.ItemTexture
		
		if Slots.Amount > 1:
			AmountText.visible = true
			
		else:
			AmountText.visible = false
			
		AmountText.text = str(Slots.Amount)
