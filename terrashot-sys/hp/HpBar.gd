extends AnimatedSprite2D

@onready var HpBar = self

func _process(delta: float) -> void:
	
	if Global.PlayerHp == 5:
		HpBar.play("5") 

	if Global.PlayerHp == 4:
		HpBar.play("4") 

	if Global.PlayerHp == 3:
		HpBar.play("3") 

	if Global.PlayerHp == 2:
		HpBar.play("2") 

	if Global.PlayerHp == 1:
		HpBar.play("1") 

	if Global.PlayerHp == 0:
		HpBar.play("0") 
