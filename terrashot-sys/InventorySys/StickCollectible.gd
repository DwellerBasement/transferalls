extends StaticBody2D

@export var Item: InvItem
var Player = null

func _on_interactable_area_body_entered(body: Node2D) -> void:
	print("the tihng as happede")
	if body.is_in_group("Player"):
		Player = body
		playercollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()

func playercollect():
	Player.collect(Item)
